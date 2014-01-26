require "spec_helper"

describe BeerClubsController do
  describe "routing" do

    it "routes to #index" do
      get("/beer_clubs").should route_to("beer_clubs#index")
    end

    it "routes to #new" do
      get("/beer_clubs/new").should route_to("beer_clubs#new")
    end

    it "routes to #show" do
      get("/beer_clubs/1").should route_to("beer_clubs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/beer_clubs/1/edit").should route_to("beer_clubs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/beer_clubs").should route_to("beer_clubs#create")
    end

    it "routes to #update" do
      put("/beer_clubs/1").should route_to("beer_clubs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/beer_clubs/1").should route_to("beer_clubs#destroy", :id => "1")
    end

  end
end
