require "spec_helper"

describe BetaSignupsController do
  describe "routing" do

    it "routes to #index" do
      get("/beta_signups").should route_to("beta_signups#index")
    end

    it "routes to #new" do
      get("/beta_signups/new").should route_to("beta_signups#new")
    end

    it "routes to #show" do
      get("/beta_signups/1").should route_to("beta_signups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/beta_signups/1/edit").should route_to("beta_signups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/beta_signups").should route_to("beta_signups#create")
    end

    it "routes to #update" do
      put("/beta_signups/1").should route_to("beta_signups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/beta_signups/1").should route_to("beta_signups#destroy", :id => "1")
    end

  end
end
