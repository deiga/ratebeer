require 'spec_helper'

describe StylesController do

  let (:style) { create :style }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: style
      expect(response).to be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', id: style
      expect(response).to be_success
    end
  end

end
