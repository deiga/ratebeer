require "spec_helper"

describe MembershipsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/memberships")).to route_to("memberships#index")
    end

    it "routes to #new" do
      expect(get("/memberships/new")).to route_to("memberships#new")
    end

    it "routes to #show" do
      expect(get("/memberships/1")).to route_to("memberships#show", id: "1")
    end

    it "routes to #create" do
      expect(post("/memberships")).to route_to("memberships#create")
    end

    it "routes to #destroy" do
      expect(delete("/memberships/1")).to route_to("memberships#destroy", id: "1")
    end

  end
end
