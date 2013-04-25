require 'spec_helper'

describe UserInformation do
  describe "Searching" do
    before(:each) do
      UserInformation.tire.index.delete
      UserInformation.create_elasticsearch_index
      @user_1 = UserInformation.create({
        :user_id => "100005196784043",
        :user_name  => "Rajan Punchouty",
        :email =>  "rajan.punchouty@gmail.com"
      })
      
       @user_2 = UserInformation.create({
        :user_id => "100005735493567",
        :user_name  => "Parminder Singh",
        :email =>  "parminder@ezzie.in"
      })
      
      UserInformation.all.each do |s|
        s.tire.update_index 
      end
      UserInformation.tire.index.refresh
    end
    
     context "Searching" do
      describe "users" do
        it "should find users by id" do
          result = UserInformation.search(:user_id => "100005196784043")
          result.count.should == 1
          result.first.user_name.should == @user_1.user_name
        end        
      end
    end
  end
end
