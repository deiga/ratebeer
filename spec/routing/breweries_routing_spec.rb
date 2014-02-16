require "spec_helper"

describe BreweriesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/breweries")).to route_to("breweries#index")
    end

    it "routes to #new" do
      expect(get("/breweries/new")).to route_to("breweries#new")
    end

    it "routes to #show" do
      expect(get("/breweries/1")).to route_to("breweries#show", id: "1")
    end

    it "routes to #edit" do
      expect(get("/breweries/1/edit")).to route_to("breweries#edit", id: "1")
    end

    it "routes to #create" do
      expect(post("/breweries")).to route_to("breweries#create")
    end

    it "routes to #update" do
      expect(put("/breweries/1")).to route_to("breweries#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete("/breweries/1")).to route_to("breweries#destroy", id: "1")
    end

  end
end
