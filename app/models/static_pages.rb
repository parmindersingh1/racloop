class StaticPages 
  
 include Tire::Model::Persistence
  
  validates_presence_of :user_name,:user_id,:from, :to, :date_at, :have_car,:distance_time,:from_location,:to_location
  
      property :user_name,    :type=> 'string' 
      property :user_id,      :type=> 'string'  
      property :from,         :type=> 'string'
      property :from_location,:type=> 'geo_point'
      property :to,           :type=> 'string'
      property :to_location,  :type=> 'geo_point'
      property :date_at,      :type=> 'date' 
      property :have_car,     :type=> 'boolean'
      property :distance_time,:type=> 'string'
      property :submit_time,  :type=> 'date', :default => Time.zone.now.utc
            
  def self.search(params)
    tire.search do
          puts"**********************#{params}"          
          query {all}             
          filter :range, date_at: {gte: Time.zone.now+1.hours }  
          filter :range, date_at: {lte: params[:search_futuretime]}
          filter :range, date_at: {gte: params[:search_pasttime]}
          filter :bool,:must_not=>{:term=>{ :user_id => params[:user_id]}}
          filter('geo_distance', {:distance =>  params[:distance], 
        :from_location => {'lat' => params[:from_lat].to_f, 'lon' => params[:from_lon].to_f}}
              ) if params[:from_lat] && params[:from_lon]
              
          filter('geo_distance', {:distance => "20km", 
        :to_location => {'lat' => params[:to_lat].to_f, 'lon' => params[:to_lon].to_f}}
              ) if params[:to_lat] && params[:to_lon]
                   
          sort { by :date_at, "desc" }
              
           if(params[:have_car]=="true")
             puts "++++++++++++++++with car"            
            filter :term, :have_car => false
           else
            puts "++++++++++++++++without car"           
            filter :term, :have_car => true
           end          
     end
   end
   
   def self.search_nearby(params)
     tire.search do
       puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%#{params[:lat]}%%%%%%%%%#{params[:lon]}"
       query {all}  
       size 15 
       filter  :bool,:must_not=>{:term=>{ :user_id => params[:user_id]}}
       filter('geo_distance', {:distance => "20km", 
        :from_location => {'lat' => params[:lat].to_f, 'lon' => params[:lon].to_f}}
              ) if params[:lat] && params[:lon]
       filter :range, date_at: {gte: Time.zone.now}      
       sort { by :date_at, "desc" }
     end
   end
   
   def self.search_history(params)
     tire.search do       
       query do        
         string "user_id:#{params[:user_id]}"
       end    
       size 20   
       filter :range, date_at: {lt: Time.zone.now}      
       sort { by :date_at, "desc" }
     end     
   end
   
   def self.search_request(params)
     tire.search do       
       query do
         string "user_id:#{params[:user_id]}"
       end         
       filter :range, date_at: {gt: Time.zone.now}      
       sort { by :submit_time, "desc" }
     end     
   end  
   
   def self.search_near(params)
     tire.search do
       puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%#{params[:lat]}%%%%%%%%%#{params[:lon]}"
       query {all}  
       size 15       
       filter('geo_distance', {:distance => "20km", 
        :from_location => {'lat' => params[:lat].to_f, 'lon' => params[:lon].to_f}}
              ) if params[:lat] && params[:lon]
       filter :range, date_at: {gte: Time.zone.now}      
       sort { by :date_at, "desc" }
     end
   end
   
   def self.search_no_of_requests(params)
     tire.search do       
       query do
         string "user_id:#{params[:user_id]}"
       end        
     end     
   end  
   
end



