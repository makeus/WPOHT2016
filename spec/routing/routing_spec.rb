require "rails_helper"

RSpec.describe ContactsController, type: :routing do
  describe "contact routing" do
    it "routes to #create" do
      expect(:post => "/contacts").to route_to("contacts#create")
    end
  end

  describe "card routing" do
    it "routes to #index" do
      expect(:get => "/").to route_to("cards#index")
      expect(:get => "/cards").to route_to("cards#index")
    end
    it "routes to show" do
      expect(:get => "/cards/13082319").to route_to("cards#show", :id=>"13082319")
    end
  end
end
