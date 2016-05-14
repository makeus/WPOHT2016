require 'rails_helper'

describe "OtApi" do
  before :each do
    Rails.cache.clear
  end
  describe "#getCards" do
    it "parses simple parameters, calls proper url and returns" do

      canned_answer = <<-END_OF_STRING
      {"cards":[{"id":13039686,"description":"Tyylik\u00e4s ja valoisa 4\/5 kerroksen kulmahuoneisto halutussa ja vehre\u00e4ss\u00e4 Vuoreksen uudessa kaupunginosassa","rooms":1,"roomConfiguration":"1h, kt, kph, parveke","price":"122\u00a0800\u00a0\u20ac","nextViewing":null,"images":{"wide":"http:\/\/asunnot.oikotie-static.edgesuite.net\/623*464\/142\/790\/wide\/142790490.jpg","thumb":"http:\/\/asunnot.oikotie-static.edgesuite.net\/215*161\/142\/790\/thumb_search\/142790490.jpg"},"newDevelopment":true,"published":"2016-04-30T12:18:09Z","size":32.5,"sizeLot":4700,"cardType":100,"contractType":1,"onlineOffer":null,"extraVisibility":null,"extraVisibilityString":null,"buildingData":{"address":"Koukkurannankatu 6 B 68","district":"Vuores","city":"Tampere","year":2016,"buildingType":1},"coordinates":{"latitude":61.43212,"longitude":23.80451},"brand":{"image":"http:\/\/asunnot.oikotie-static.edgesuite.net\/300*260\/143\/107\/company_image\/143107554.jpg","name":"Kiinteist\u00f6maailma, Koskikeskuksen Asuntopalvelu Oy LKV, Tampere","id":5013593},"priceChanged":null,"visits":0,"visits_weekly":0}],"found":51321,"start":1}
      END_OF_STRING

      stub_request(:get, /.*cards.*((\?|&)limit=1|(\?|&)offset=0|(\?|&)cardType=100){3}/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

      response = OtApi.new.getCards({
        limit: 1,
        offset: 0,
        cardType: 100
        });

      expect(response["found"]).to eq(51321)
      expect(response["cards"][0]["id"]).to eq(13039686)
    end

    it "parses price parameters, calls proper url and returns" do
      canned_answer = <<-END_OF_STRING
      {"cards":[{"id":13039686,"description":"Tyylik\u00e4s ja valoisa 4\/5 kerroksen kulmahuoneisto halutussa ja vehre\u00e4ss\u00e4 Vuoreksen uudessa kaupunginosassa","rooms":1,"roomConfiguration":"1h, kt, kph, parveke","price":"122\u00a0800\u00a0\u20ac","nextViewing":null,"images":{"wide":"http:\/\/asunnot.oikotie-static.edgesuite.net\/623*464\/142\/790\/wide\/142790490.jpg","thumb":"http:\/\/asunnot.oikotie-static.edgesuite.net\/215*161\/142\/790\/thumb_search\/142790490.jpg"},"newDevelopment":true,"published":"2016-04-30T12:18:09Z","size":32.5,"sizeLot":4700,"cardType":100,"contractType":1,"onlineOffer":null,"extraVisibility":null,"extraVisibilityString":null,"buildingData":{"address":"Koukkurannankatu 6 B 68","district":"Vuores","city":"Tampere","year":2016,"buildingType":1},"coordinates":{"latitude":61.43212,"longitude":23.80451},"brand":{"image":"http:\/\/asunnot.oikotie-static.edgesuite.net\/300*260\/143\/107\/company_image\/143107554.jpg","name":"Kiinteist\u00f6maailma, Koskikeskuksen Asuntopalvelu Oy LKV, Tampere","id":5013593},"priceChanged":null,"visits":0,"visits_weekly":0}],"found":51321,"start":1}
      END_OF_STRING

      stub_request(:get, /.*cards.*((\?|&)price%5Bmax%5D=10000|(\?|&)price%5Bmin%5D=2000|(\?|&)cardType=100){3}/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

      response = OtApi.new.getCards({
        price: {
          max: 10000,
          min: 2000
        },
        cardType: 100
        });

      expect(response["found"]).to eq(51321)
      expect(response["cards"][0]["id"]).to eq(13039686)
    end

    describe 'locationParameter' do
      it 'parses single location, calls proper url and returns' do
        canned_answer = <<-END_OF_STRING
        {"cards":[{"id":13039686,"description":"Tyylik\u00e4s ja valoisa 4\/5 kerroksen kulmahuoneisto halutussa ja vehre\u00e4ss\u00e4 Vuoreksen uudessa kaupunginosassa","rooms":1,"roomConfiguration":"1h, kt, kph, parveke","price":"122\u00a0800\u00a0\u20ac","nextViewing":null,"images":{"wide":"http:\/\/asunnot.oikotie-static.edgesuite.net\/623*464\/142\/790\/wide\/142790490.jpg","thumb":"http:\/\/asunnot.oikotie-static.edgesuite.net\/215*161\/142\/790\/thumb_search\/142790490.jpg"},"newDevelopment":true,"published":"2016-04-30T12:18:09Z","size":32.5,"sizeLot":4700,"cardType":100,"contractType":1,"onlineOffer":null,"extraVisibility":null,"extraVisibilityString":null,"buildingData":{"address":"Koukkurannankatu 6 B 68","district":"Vuores","city":"Tampere","year":2016,"buildingType":1},"coordinates":{"latitude":61.43212,"longitude":23.80451},"brand":{"image":"http:\/\/asunnot.oikotie-static.edgesuite.net\/300*260\/143\/107\/company_image\/143107554.jpg","name":"Kiinteist\u00f6maailma, Koskikeskuksen Asuntopalvelu Oy LKV, Tampere","id":5013593},"priceChanged":null,"visits":0,"visits_weekly":0}],"found":51321,"start":1}
        END_OF_STRING

        stub_request(:get, /.*cards.*((\?|&)locations=%5B%5B1,9,%22Suomi%22%5D%5D|(\?|&)cardType=100){2}/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

        response = OtApi.new.getCards({
          location: ['FI'],
          cardType: 100
          });

        expect(response["found"]).to eq(51321)
        expect(response["cards"][0]["id"]).to eq(13039686)
      end

      it 'parses multiple locations, calls proper url and returns' do
        canned_answer = <<-END_OF_STRING
        {"cards":[{"id":13039686,"description":"Tyylik\u00e4s ja valoisa 4\/5 kerroksen kulmahuoneisto halutussa ja vehre\u00e4ss\u00e4 Vuoreksen uudessa kaupunginosassa","rooms":1,"roomConfiguration":"1h, kt, kph, parveke","price":"122\u00a0800\u00a0\u20ac","nextViewing":null,"images":{"wide":"http:\/\/asunnot.oikotie-static.edgesuite.net\/623*464\/142\/790\/wide\/142790490.jpg","thumb":"http:\/\/asunnot.oikotie-static.edgesuite.net\/215*161\/142\/790\/thumb_search\/142790490.jpg"},"newDevelopment":true,"published":"2016-04-30T12:18:09Z","size":32.5,"sizeLot":4700,"cardType":100,"contractType":1,"onlineOffer":null,"extraVisibility":null,"extraVisibilityString":null,"buildingData":{"address":"Koukkurannankatu 6 B 68","district":"Vuores","city":"Tampere","year":2016,"buildingType":1},"coordinates":{"latitude":61.43212,"longitude":23.80451},"brand":{"image":"http:\/\/asunnot.oikotie-static.edgesuite.net\/300*260\/143\/107\/company_image\/143107554.jpg","name":"Kiinteist\u00f6maailma, Koskikeskuksen Asuntopalvelu Oy LKV, Tampere","id":5013593},"priceChanged":null,"visits":0,"visits_weekly":0}],"found":51321,"start":1}
        END_OF_STRING

        stub_request(:get, /.*cards.*((\?|&)locations=%5B%5B1,9,%22Suomi%22%5D,%5B679888,9,%22Ruotsi%22%5D,%5B679947,9,%22Viro%22%5D,%5B679760,9,%22Espanja%22%5D,%5B679881,9,%22Ranska%22%5D,%5B679865,9,%22Norja%22%5D%5D|(\?|&)cardType=100){2}/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

        response = OtApi.new.getCards({
          location: ['FI', 'SE', 'EE', 'ES', 'FR', 'NO'],
          cardType: 100
          });

        expect(response["found"]).to eq(51321)
        expect(response["cards"][0]["id"]).to eq(13039686)
      end
    end

    describe 'featuresPamater' do
      it 'parses single feature, calls proper url and returns' do
        canned_answer = <<-END_OF_STRING
        {"cards":[{"id":13039686,"description":"Tyylik\u00e4s ja valoisa 4\/5 kerroksen kulmahuoneisto halutussa ja vehre\u00e4ss\u00e4 Vuoreksen uudessa kaupunginosassa","rooms":1,"roomConfiguration":"1h, kt, kph, parveke","price":"122\u00a0800\u00a0\u20ac","nextViewing":null,"images":{"wide":"http:\/\/asunnot.oikotie-static.edgesuite.net\/623*464\/142\/790\/wide\/142790490.jpg","thumb":"http:\/\/asunnot.oikotie-static.edgesuite.net\/215*161\/142\/790\/thumb_search\/142790490.jpg"},"newDevelopment":true,"published":"2016-04-30T12:18:09Z","size":32.5,"sizeLot":4700,"cardType":100,"contractType":1,"onlineOffer":null,"extraVisibility":null,"extraVisibilityString":null,"buildingData":{"address":"Koukkurannankatu 6 B 68","district":"Vuores","city":"Tampere","year":2016,"buildingType":1},"coordinates":{"latitude":61.43212,"longitude":23.80451},"brand":{"image":"http:\/\/asunnot.oikotie-static.edgesuite.net\/300*260\/143\/107\/company_image\/143107554.jpg","name":"Kiinteist\u00f6maailma, Koskikeskuksen Asuntopalvelu Oy LKV, Tampere","id":5013593},"priceChanged":null,"visits":0,"visits_weekly":0}],"found":51321,"start":1}
        END_OF_STRING

        stub_request(:get, /.*cards.*((\?|&)keywords\[\]=Sauna|(\?|&)cardType=100){2}/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

        response = OtApi.new.getCards({
          features: ['sauna'],
          cardType: 100
          });

        expect(response["found"]).to eq(51321)
        expect(response["cards"][0]["id"]).to eq(13039686)
      end

      it 'parses multiple features, calls proper url and returns' do
        canned_answer = <<-END_OF_STRING
        {"cards":[{"id":13039686,"description":"Tyylik\u00e4s ja valoisa 4\/5 kerroksen kulmahuoneisto halutussa ja vehre\u00e4ss\u00e4 Vuoreksen uudessa kaupunginosassa","rooms":1,"roomConfiguration":"1h, kt, kph, parveke","price":"122\u00a0800\u00a0\u20ac","nextViewing":null,"images":{"wide":"http:\/\/asunnot.oikotie-static.edgesuite.net\/623*464\/142\/790\/wide\/142790490.jpg","thumb":"http:\/\/asunnot.oikotie-static.edgesuite.net\/215*161\/142\/790\/thumb_search\/142790490.jpg"},"newDevelopment":true,"published":"2016-04-30T12:18:09Z","size":32.5,"sizeLot":4700,"cardType":100,"contractType":1,"onlineOffer":null,"extraVisibility":null,"extraVisibilityString":null,"buildingData":{"address":"Koukkurannankatu 6 B 68","district":"Vuores","city":"Tampere","year":2016,"buildingType":1},"coordinates":{"latitude":61.43212,"longitude":23.80451},"brand":{"image":"http:\/\/asunnot.oikotie-static.edgesuite.net\/300*260\/143\/107\/company_image\/143107554.jpg","name":"Kiinteist\u00f6maailma, Koskikeskuksen Asuntopalvelu Oy LKV, Tampere","id":5013593},"priceChanged":null,"visits":0,"visits_weekly":0}],"found":51321,"start":1}
        END_OF_STRING

        stub_request(:get, /.*cards.*((\?|&)keywords\[\]=Sauna|(\?|&)keywords\[\]=Ranta|(\?|&)keywords\[\]=Autotalli|(\?|&)keywords\[\]=Uima-allas|(\?|&)cardType=100){5}/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

        response = OtApi.new.getCards({
          features: ['sauna', 'garage', 'pool', 'shore'],
          cardType: 100
          });

        expect(response["found"]).to eq(51321)
        expect(response["cards"][0]["id"]).to eq(13039686)
      end
    end
  end

  describe "#getCard" do
    it "calls proper url" do

      canned_answer = <<-END_OF_STRING
      {"pageName":"property","notifcationPage":4,"card_id":"13057713","ad":{"ad_lot_sell_id":13057713,"primary_address_id":915884,"user_id":null,"availability_date":null,"building_rights":null,"contract_type":1,"debt_payable":null,"igglo_id":"7125123","is_rented":null,"lot_type":8,"price":365000,"published":"2016-05-05 08:28:15","published_search_sort":"2016-05-05 08:28:15","first_showing":null,"road_access":null,"sell_status":3,"shore_ownership_type":null,"shore_type":null,"size":1760,"source_type":1,"status":1,"title":"Hienolla paikalla, p\u00e4\u00e4ttyv\u00e4n tien varrella, puiston laidalla 2 rakennuspaikkaa"},"adExtra":{"ad_lot_sell_id":13057713,"private_vendor_ad_id":null,"address_info":"Muuttolinnunreitti 3","area_description_info":null,"attachments_info":null,"attachments_url":null,"antenna_system_info":null,"availability_info":"heti vapaa","building_override_building_plan_info":null,"building_override_building_plan_situation":null,"building_override_lot_ownership":1,"building_override_lot_ownership_info":null,"cable_tv_charge":null,"cable_tv_charge_unit":null,"buyer_costs":null,"building_rights_unit":null,"comment":null,"connections_info":null,"contact_email":"espoo@huoneistokeskus.fi","contact_email_2":null,"contact_email_3":null,"contact_address":null,"contact_name":"Aleksi Tiihonen","contact_person_picture_url":"https:\/\/api.realia.fi\/hk\/api\/odata\/v2\/Brokers(2997)\/Image","contact_phone":"020 780 3408, 040 630 2875","contact_show":null,"contract_date":null,"description":"Hienolla paikalla, p\u00e4\u00e4ttyv\u00e4n tien varrella, puiston laidalla 2 rakennuspaikkaa. Tontilla sijaitsee purkukuntoinen rakennus. Asemakaava vireill\u00e4. Maaper\u00e4 normaalisti rakennettava. Lis\u00e4tiedot ja yhteydenotot: Aleksi Tiihonen 0406302875 \/ aleksi.tiihonen@huoneistokeskus.fi","description_supplementary":null,"direction_info":null,"driving_instructions":null,"encumbrances_info":null,"estate_ownership_type":0,"estate_tax":null,"financial_fee":null,"financing_offer_1_fee":null,"financing_offer_1_percentage":null,"financing_offer_1_price":null,"financing_offer_2_fee":null,"financing_offer_2_percentage":null,"financing_offer_2_price":null,"fishing_right":null,"forest_land_area":null,"forest_size_info":null,"grounds_info":null,"hobby_possibilities":null,"honoring_clause":null,"hunting_right":null,"link_text":null,"living_area_info":null,"living_area_type":null,"lot_repurchase_price":null,"inquiries":null,"mode_of_financing":null,"more_info_text":null,"mortgages_info":null,"municipal_development_info":null,"other_buildings_info":null,"other_fees_info":null,"partner_paper":0,"price_sell":365000,"publish_purchase_price":null,"real_estate_id":null,"rented":null,"sanitation_info":null,"road_costs":null,"sell_comments":null,"sell_date":null,"sell_type":null,"sender_node":"HK-ES","services_info":null,"shore":null,"shore_direction":null,"shore_length":null,"shore_info":null,"shores_description_info":null,"show_lead_form":null,"size_floor":null,"use_of_water":null,"vista_info":null,"virtual_presentation_text":null,"virtual_presentation_url":null,"waters":null,"waters_info":null,"district_info":"Lintuvaara","city_info":"Espoo","zip_code_info":"02660"},"additionalInfo":{"card_id":13057713,"apartment_city_plan_id":null,"appliances_internet":null,"appliances_bedroom":null,"appliances_livingroom":null,"appliances_nonincluded":null,"appliances_other":null,"appliances_tv":null,"background_image":null,"background_color":null,"city_area_id":null,"contact_person_title":null,"contact_person_rating":null,"contact_person_degrees":null,"contact_person_some_url":null,"contact_person_some":null,"estate_name":null,"estate_info":null,"floor_bathroom":null,"floor_bedroom":null,"floor_kitchen":null,"floor_livingroom":null,"other_materials":null,"other_spaces":null,"postal_area_id":null,"parking_space_type":null,"parking_space_heated":null,"parking_space_electricity":null,"redemption_price":null,"shore_direction":null,"shore_length":null,"site_rent_end":null,"start_of_use_year":null,"terrace":null,"ventilation_system":null,"vrk_id":null,"vrk_apartment_id":null,"wall_bathroom":null,"wall_bedroom":null,"wall_kitchen":null,"wall_livingroom":null},"medias":[{"media_id":146272488,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272494,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272497,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272500,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272506,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272509,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272512,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272503,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":146272515,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1}],"district":{"district_id":893,"city_id":39,"name":"Suurhuopalahti","status":1},"address":{"address_id":915884,"street_id":39381,"street_number":"3","building_letter":null,"zip_code_id":14861,"status":1},"city":{"city_id":39,"county_id":2,"name":"Espoo","status":1},"street":{"street_id":39381,"city_id":39,"name":"Muuttolinnunreitti","status":1,"name_swe":"Flyttf\u00e5gelsstr\u00e5ket"},"company":{"company_id":5011953,"oikotie_company_id":3084},"oikotieCompany":{"ID":3084,"MARKETING_NAME":"Huoneistokeskus Espoo Tapiola","EXTERNAL_ID":"ES","TRADE_REGISTRY_NUMBER":"0000000-0","COMPANY_STATUS":"ACTIVE","COMPANY_TYPE":"REAL ESTATE AGENT","STREET_ADDRESS":"Tapiontori 3 B","ZIP_CODE":"02100","CITY":"Espoo","COUNTY":"Uusimaa","IS_FOREIGN_COMPANY":0,"EMAIL_ADDRESS":"espoo@huoneistokeskus.fi","LEAD_EMAIL_ADDRESS":null,"PHONE_NUMBER":"0207 80 3424","FAX_NUMBER":null,"MAP_COORDINATE_LAT":"3374131","MAP_COORDINATE_LON":"6674884","PARENT_COMPANY_ID":3746,"PARENT_COMPANY_NAME":"Huoneistokeskus","CHANGED_DATE":"2013-03-21 14:11:13","HAS_LISTLOGO":0,"HAS_CONTRACT":1,"HAS_ADGUARANTEE":0,"IS_SELF_REGISTERED":0,"IS_CREDITABLE":1,"HAS_FREESPEE":0,"SELLER_ID":7},"coordinates":{"card_id":13057713,"latitude":60.248058842634,"longitude":24.81496194372},"viewings":[],"logo1":"http:\/\/asunnot.oikotie-static.edgesuite.net\/240*40\/121\/321\/logo\/121321072.jpg","logo2":"http:\/\/asunnot.oikotie-static.edgesuite.net\/240*40\/121\/321\/logo\/121321122.jpg","zipCode":{"zip_code_id":14861,"city_id":39,"zip_code":"02660","name":"Espoo","status":1},"notifications":[]}
      END_OF_STRING

      stub_request(:get, /.13057713./).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

      response = OtApi.new.getCard(13057713);

      expect(response["card_id"]).to eq("13057713")
      expect(response["ad"]["price"]).to eq(365000)
    end
  end
end