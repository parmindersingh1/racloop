require "spec_helper"

describe UserInformationsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_informations").should route_to("user_informations#index")
    end

    it "routes to #new" do
      get("/user_informations/new").should route_to("user_informations#new")
    end

    it "routes to #show" do
      get("/user_informations/1").should route_to("user_informations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_informations/1/edit").should route_to("user_informations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_informations").should route_to("user_informations#create")
    end

    it "routes to #update" do
      put("/user_informations/1").should route_to("user_informations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_informations/1").should route_to("user_informations#destroy", :id => "1")
    end

  end
end
