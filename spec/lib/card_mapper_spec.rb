require 'rails_helper'

describe "CardMapper" do

  describe "#mapCard" do

    describe "init" do 
      it "should by default create card with given id" do 
        CardMapper.new.mapCard card_id: 13057713
        expect(Card.count).to eq(1)
      end

      it "should not create a new one when previous exist" do
        card = FactoryGirl.create(:card)
        expect(Card.count).to eq(1)
        card = CardMapper.new.mapCard card_id: card.id
        expect(Card.count).to eq(1)
        expect(card).to eq(Card.first)
      end
    end

    describe "coordinates" do
      it "should by default not create coordinates if none are given" do
        CardMapper.new.mapCard card_id: 13057713
        expect(Coordinate.count).to eq(0)
      end

      it "should create new coordinates from given data" do
        CardMapper.new.mapCard card_id: 13057713, coordinates: {latitude: 60.248058842634, longitude: 24.81496194372}
        expect(Coordinate.count).to eq(1)
        coordinates = Coordinate.first
        expect(coordinates.latitude).to eq(60.248058842634)
        expect(coordinates.longitude).to eq(24.81496194372)
        expect(coordinates.card.id).to eq(13057713)
      end
    end

    describe "locations" do
      it "should by default not create coordinates if none are given" do
        CardMapper.new.mapCard card_id: 13057713
        expect(Location.count).to eq(0)
      end

      it "should create new coordinates from given data" do
        CardMapper.new.mapCard card_id: 13057713, address: {
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
        CardMapper.new.mapCard card_id: 13057713, address: {
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
        CardMapper.new.mapCard card_id: 13057713, 
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
        CardMapper.new.mapCard card_id: 13057713
        expect(Medium.count).to eq(0)
      end

      it "should create new medium from given data with proper url" do
        CardMapper.new.mapCard card_id: 13057713, medias: [{media_id: 146272488}] 
        expect(Medium.count).to eq(1)
        media = Medium.first
        expect(media.url).to eq("http://asunnot.oikotie-static.edgesuite.net/623*464/146/272/wide/146272488.jpg")
        expect(media.card.id).to eq(13057713)
      end

      it "should create multiply new media from given data with proper url" do
        CardMapper.new.mapCard card_id: 13057713, medias: [{media_id: 146272488}, {media_id: 146272494}] 
        expect(Medium.count).to eq(2)
      end
    end

    describe "seller" do
      it "should by default not create seller if none are given" do
        CardMapper.new.mapCard card_id: 13057713
        expect(Seller.count).to eq(0)
      end

      it "should by default create seller and ad seller id to card" do
        CardMapper.new.mapCard card_id: 13057713, logo1: "http://asunnot.oikotie-static.edgesuite.net/240*40/121/321/logo/121321072.jpg", adExtra: {
          contact_name: "Testi Testinen",
          contact_person_picture_url: "www.testurl.com/A/B.jpg"
        }
        expect(Seller.count).to eq(1)
        seller = Seller.first
        expect(Card.first.seller_id).to eq(seller.id)
        expect(seller.name).to eq("Testi Testinen")
        expect(seller.logo).to eq("http://asunnot.oikotie-static.edgesuite.net/240*40/121/321/logo/121321072.jpg");
      end
    end

    describe "feature" do
      it "should by defualt not create any features" do
        CardMapper.new.mapCard card_id: 13057713
        expect(Feature.count).to eq(0)
      end

      it "should create some features if exist with proper format" do
        CardMapper.new.mapCard card_id: 13057713, ad: {price: 12000}, adExtra: {description: "kuvaus"}
        expect(Feature.count).to eq(2)
        feature = Feature.first 
        expect(feature.feature).to eq("price")
        expect(feature.value).to eq("12 000 €")
      end

      it "should create some features from description" do
        CardMapper.new.mapCard card_id: 13057713, ad: {}, adExtra: {description: "sauna ja kiva uima-allas"}
        expect(Feature.count).to eq(3)
        sauna = Feature.find_by feature: 'sauna'
        expect(sauna.value).to eq('t')
        garage = Feature.find_by feature: 'garage'
        if !garage.nil?
          expect(garage.value).to eq('f')
        end
      end

    end
  end
end