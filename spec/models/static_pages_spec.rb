require 'spec_helper'

describe StaticPages do
 describe "Searching" do
    before(:each) do
      StaticPages.tire.index.delete
      StaticPages.create_elasticsearch_index
      @user_1 = StaticPages.create({
        :user_id => "100005196784043",
        :user_name  => "Rajan Punchouty",
        :from   => "Sector 17, Chandigarh, India" ,
        :from_location => "30.7398339, 76.78270199999997",
        :to     => "Gurgaon, Haryana, India",
        :to_location => "28.4594965, 77.02663830000006",
        :date_at => "2013-04-24T04:00:00",
        :have_car => "false",
        :distance_time => "277.44,268"
      })
      
       @user_2 = StaticPages.create({
        :user_id => "100005735493567",
        :user_name  => "Parminder Singh",
        :from   => "Sector 26, Chandigarh, India" ,
        :from_location => "30.7299586, 76.81010379999998",
        :to     => "Delhi Cantonment, New Delhi, Delhi, India",
        :to_location => "28.586738, 77.13199889999999",
        :date_at => "2013-04-30T04:10:00",
        :have_car => "true",
        :distance_time => "257.533,253"
      })
      
      @user_3 = StaticPages.create({
        :user_id => "100002283355067",
        :user_name  => "Anu Sharma",
        :from   => "Sector 22, Chandigarh, India" ,
        :from_location => "30.732999, 76.77116260000003",
        :to     => "Akshardham, Noida Link Road, Ganesh Nagar, Patparganj, Delhi, India",
        :to_location => "28.617988, 77.27937199999997",
        :date_at => "2013-04-30T04:30:00",
        :have_car => "true",
        :distance_time => "258.61,246"
      })
      
      @params={
        :user_id => "100005196784043",       
        :date_at => "2013-04-30T03:00:00",
        :have_car => "false",
        :distance => "258.61",
        :search_futuretime => "2013-04-30T08:00:00",
        :search_pasttime => "2013-04-30T01:00:00",
        :from_lat => "30.732999",
        :from_lon => "76.77116260000003", 
        :to_lat=> "28.617988", 
        :to_lon => "77.27937199999997"
      }
      
      StaticPages.all.each do |s|
        s.tire.update_index 
      end
      StaticPages.tire.index.refresh
    end
    
     context "Searching" do
      describe "search method" do
        it "should return result " do
          result = StaticPages.search(@params)
          result.count.should == 2
          result.first.user_name.should == @user_3.user_name
        end      
        
        it "should return nearby result" do
          result = StaticPages.search_nearby(:user_id => "100005196784043",:lat => "30.732999",:lon => "76.77116260000003",:date_at=>"2013-04-30T01:00:00" )
          result.count.should == 2
          result.first.user_name.should == @user_3.user_name
        end    
        
        it "should return history result" do
          result = StaticPages.search_history(:user_id => "100005196784043")
          result.count.should == 1
          result.first.user_name.should == @user_1.user_name
        end     
        
        it "should return request result" do
          result = StaticPages.search_request(:user_id => "100002283355067")
          result.count.should == 1
          result.first.user_name.should == @user_3.user_name
        end     
        
        it "should return near result" do
          result = StaticPages.search_near(:user_id => "100005196784043",:lat => "30.732999",:lon => "76.77116260000003" )
          result.count.should == 2
          result.first.user_name.should == @user_3.user_name
        end      
        
        it "should return no of requests result" do
          result = StaticPages.search_no_of_requests(:user_id => "100005196784043")
          result.count.should == 1
          result.first.user_name.should == @user_1.user_name
        end   
      end
    end
  end
end
