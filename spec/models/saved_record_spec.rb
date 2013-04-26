require 'spec_helper'

describe SavedRecord do
  describe "Searching" do
    before(:each) do
      SavedRecord.tire.index.delete
      SavedRecord.create_elasticsearch_index
      @user_1 = SavedRecord.create({
        :user_id => "100005196784043",
        :user_name  => "Rajan Punchouty",
        :from   => "Sector 17, Chandigarh, India" ,
        :from_location => "30.7398339, 76.78270199999997",
        :to     => "Tamil Nadu, India",
        :to_location => "11.1271225, 78.65689420000001"
      })
      
       @user_2 = SavedRecord.create({
        :user_id => "100005735493567",
        :user_name  => "Parminder Singh",
        :from   => "Sector 26, Chandigarh, India" ,
        :from_location => "30.7299586, 76.81010379999998",
        :to     => "Delhi Cantonment, New Delhi, Delhi, India",
        :to_location => "28.586738, 77.13199889999999",
      })
      
      SavedRecord.all.each do |s|
        s.tire.update_index 
      end
      SavedRecord.tire.index.refresh
    end
    
     context "Searching" do
      describe "saved records" do
        it "should return result by id" do
          result = SavedRecord.search(:user_id => "100005196784043")
          assert_equal 1, result.count
          result.first.user_name.should == @user_1.user_name
        end      
        
        it "should return result" do
          result = SavedRecord.search_check(:user_id => "100005735493567",:from_lat => "30.732999",:from_lon => "76.77116260000003", :to_lat=> "28.617988", :to_lon => "77.27937199999997")
          assert_equal 1, result.count
          result.first.user_name.should == @user_2.user_name
        end          
      end
    end
  end
end
