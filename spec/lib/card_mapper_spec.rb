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
        expect(coordinates.card.id).to eq(13057713)
      end
    end

    describe "locations" do
      it "should by default not create coordinates if none are given" do
        CardMapper.new.mapCard id: 13057713
        expect(Location.count).to eq(0)
      end

      it "should create new coordinates from given data" do
        CardMapper.new.mapCard id: 13057713, address: {
            "address_id": 915884,
            "street_id": 39381,
            "street_number": "3",
            "building_letter": "b"
          },
          street: {
            "name": "Muuttolinnunreitti",
            "status": 1,
            "name_swe": "Flyttfågelsstråket"
          },
          city: {
            "county_id": 2,
            "name": "Espoo",
            "status": 1
          }

        expect(Location.count).to eq(1)
        location = Location.first
        expect(location.address).to eq("Muuttolinnunreitti 3 b, Espoo")
        expect(location.card.id).to eq(13057713)
      end

      it "should create proper address even with some data missing" do
        CardMapper.new.mapCard id: 13057713, address: {
            "address_id": 915884,
            "street_id": 39381,
            "street_number": nil,
            "building_letter": nil
          },
          street: {
            "name": "Muuttolinnunreitti",
            "status": 1,
            "name_swe": "Flyttfågelsstråket"
          },
          city: {
            "county_id": 2,
            "name": "Espoo",
            "status": 1
          }

        expect(Location.count).to eq(1)
        location = Location.first
        expect(location.address).to eq("Muuttolinnunreitti, Espoo")
        expect(location.card.id).to eq(13057713)
      end

      it "should create proper address even with some data missing" do
        CardMapper.new.mapCard id: 13057713, 
          address: {
            "address_id": 915884,
            "street_id": 39381,
            "street_number": "3",
            "building_letter": "b"
          },
          street: {
            "name": "Muuttolinnunreitti",
            "status": 1,
            "name_swe": "Flyttfågelsstråket"
          },
          city: {
            "county_id": 2,
            "name": nil,
            "status": 1
          }

        expect(Location.count).to eq(1)
        location = Location.first
        expect(location.address).to eq("Muuttolinnunreitti 3 b")
        expect(location.card.id).to eq(13057713)
      end
    end
    describe "media" do
      it "should by default not create media if none are given" do
        CardMapper.new.mapCard id: 13057713
        expect(Medium.count).to eq(0)
      end

      it "should create new medium from given data with proper url" do
        CardMapper.new.mapCard id: 13057713, medias: [{id: 146272488}] 
        expect(Medium.count).to eq(1)
        media = Medium.first
        expect(media.url).to eq("http://asunnot.oikotie-static.edgesuite.net/*/146/272/full/146272488.jpg")
        expect(media.card.id).to eq(13057713)
      end

      it "should create multiply new media from given data with proper url" do
        CardMapper.new.mapCard id: 13057713, medias: [{id: 146272488}, {id: 146272494}] 
        expect(Medium.count).to eq(2)
      end
    end

    describe "seller" do
      it "should by default not create seller if none are given" do
        CardMapper.new.mapCard id: 13057713
        expect(Seller.count).to eq(0)
      end

      it "should by default create seller and ad seller id to card" do
        CardMapper.new.mapCard id: 13057713, adExtra: {
          contact_name: "Testi Testinen",
          contact_person_picture_url: "www.testurl.com/A/B.jpg"
        }
        expect(Seller.count).to eq(1)
        seller = Seller.first
        expect(Card.first.seller_id).to eq(seller.id)
        expect(seller.name).to eq("Testi Testinen")
      end
    end

    describe "feature" do
      it "should by defualt not create any features" do
        CardMapper.new.mapCard id: 13057713
        expect(Feature.count).to eq(0)
      end

      it "should create some features if exist " do
        CardMapper.new.mapCard id: 13057713, ad: {price: 12000}
        expect(Feature.count).to eq(1)
        feature = Feature.first 
        expect(feature.feature).to eq("price")
        expect(feature.value).to eq("12000")
      end

    end
  end
end