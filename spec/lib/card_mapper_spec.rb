require 'rails_helper'

describe "CardMapper" do

  describe "#mapCard" do

    describe "init" do 
      it "should by default create card with given id" do 
        CardMapper.new.mapCard id: 13057713
        expect(Card.count).to eq(1)
      end

      it "should not create a new one when previous exist" do
        card = FactoryGirl.create(:card)
        expect(Card.count).to eq(1)
        CardMapper.new.mapCard id: card.id
        expect(Card.count).to eq(1)
      end
    end

    describe "coordinates" do
      it "should by default not create coordinates if none are given" do
        CardMapper.new.mapCard id: 13057713
        expect(Coordinate.count).to eq(0)
      end

      it "should create new coordinates from given data" do
        CardMapper.new.mapCard id: 13057713, coordinates: {latitude: 60.248058842634, longitude: 24.81496194372}
        expect(Coordinate.count).to eq(1)
        coordinates = Coordinate.first
        expect(coordinates.latitude).to eq(60.248058842634)
        expect(coordinates.longitude).to eq(24.81496194372)
      end
    end
  end
end