class SavedRecord 
include Tire::Model::Persistence
  
  validates_presence_of :user_name,:user_id, :from, :to, :from_location, :to_location
  
      property :user_name,    :type=> 'string' 
      property :user_id,      :type=> 'string'  
      property :from,         :type=> 'string'
      property :from_location,:type=> 'geo_point'
      property :to,           :type=> 'string'
      property :to_location,  :type=> 'geo_point'

      
  def self.search(params)
    tire.search do
      puts"**********************#{params}"          
          query {all}           
          filter :term, :user_id => params[:user_id]            
        end
    end
      
  def self.search_check(params)
    tire.search do
      puts"**********************#{params}"          
          query {all}  
         filter :term, :user_id => params[:user_id]  
         
          filter('geo_distance', {:distance => '20km', 
        :from_location => {'lat' => params[:from_lat].to_f, 'lon' => params[:from_lon].to_f}}
              ) if params[:from_lat] && params[:from_lon]
              
          filter('geo_distance', {:distance => '20km', 
        :to_location => {'lat' => params[:to_lat].to_f, 'lon' => params[:to_lon].to_f}}
              ) if params[:to_lat] && params[:to_lon]
          filter :term, :user_id => params[:user_id]            
        end
    end
     
end
