require 'spec_helper'

describe StaticPagesController do
  
  info={ :user_name=>"Rajan Punchouty",
    :email=> "rajan.punchouty@gmail.com",
    :user_id=> "100005196784043"
   }
    
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
   it "populates an array of user_information" do
     
   end
    
  end
  

 describe "GET 'Privacy'" do
    it "returns http success" do
      get 'privacy'
      response.should be_success
    end
  end
  

 describe "GET 'faq'" do
    it "returns http success" do
      get 'faq'
      response.should be_success
    end
  end

 describe "GET 'terms'" do
    it "returns http success" do
      get 'terms'
      response.should be_success

end
end
 
 describe "GET 'help' " do
  it "returns http success" do
    get 'help'
    response.should be_success
  end
 end
 
   describe "GET 'learn' " do
  it "returns http success" do
    get 'learn'
    response.should be_success
  end
 end
 
end

