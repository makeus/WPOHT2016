require 'rails_helper'

describe "OtApi" do
  describe "#getCards" do
    it "parses parameters, calls proper url and returns" do

      canned_answer = <<-END_OF_STRING
      {"cards":[{"id":13039686,"description":"Tyylik\u00e4s ja valoisa 4\/5 kerroksen kulmahuoneisto halutussa ja vehre\u00e4ss\u00e4 Vuoreksen uudessa kaupunginosassa","rooms":1,"roomConfiguration":"1h, kt, kph, parveke","price":"122\u00a0800\u00a0\u20ac","nextViewing":null,"images":{"wide":"http:\/\/asunnot.oikotie-static.edgesuite.net\/623*464\/142\/790\/wide\/142790490.jpg","thumb":"http:\/\/asunnot.oikotie-static.edgesuite.net\/215*161\/142\/790\/thumb_search\/142790490.jpg"},"newDevelopment":true,"published":"2016-04-30T12:18:09Z","size":32.5,"sizeLot":4700,"cardType":100,"contractType":1,"onlineOffer":null,"extraVisibility":null,"extraVisibilityString":null,"buildingData":{"address":"Koukkurannankatu 6 B 68","district":"Vuores","city":"Tampere","year":2016,"buildingType":1},"coordinates":{"latitude":61.43212,"longitude":23.80451},"brand":{"image":"http:\/\/asunnot.oikotie-static.edgesuite.net\/300*260\/143\/107\/company_image\/143107554.jpg","name":"Kiinteist\u00f6maailma, Koskikeskuksen Asuntopalvelu Oy LKV, Tampere","id":5013593},"priceChanged":null,"visits":0,"visits_weekly":0}],"found":51321,"start":1}
      END_OF_STRING

      stub_request(:get, /.*cards.*((\?|&)limit=1|(\?|&)offset=0|(\?|&)cardType=100){3}/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

      response = OtApi.getCards({
        limit: 1,
        offset: 0,
        cardType: 100
        });

      expect(response["found"]).to eq(51321)
      expect(response["cards"][0]["id"]).to eq(13039686)
    end
  end

  describe "#getCard" do
    it "calls proper url" do

      canned_answer = <<-END_OF_STRING
      {"pageName":"property","notifcationPage":4,"freespee_number":"0192117362","card_id":"13019904","ad":{"ad_apartment_sell_id":13019904,"building_id":11418552,"primary_address_id":11418549,"user_id":null,"apartment_condition":2,"availability_date":null,"balcony":null,"building_override_build_year":2011,"building_override_lift":0,"building_override_sauna":0,"building_rights":null,"contract_type":1,"debt_payable":null,"floor":2,"floor_count":null,"floor_location":null,"habitation_type":1,"igglo_id":"9535845","is_rented":null,"kitchen":null,"new_development":0,"new_development_status":null,"price":570000,"published":"2016-04-25 16:26:08","published_search_sort":"2016-04-25 16:26:08","first_showing":null,"room_configuration":"6-7h+k+kph+s+3xwc+khh+vh","rooms":6,"sauna":1,"sauna_charge":null,"sauna_charge_unit":null,"sell_status":3,"shore_ownership_type":null,"shore_type":null,"size":152,"size_office":null,"source_type":1,"status":1,"title":"Uudella Lasaretin alueella Haikkoossa vuonna 2011 valmistunut laadukas ja tilava omakotitalo, omalla n. 1315m\u00b2 tontilla","usage_fee":null},"adExtra":{"ad_apartment_sell_id":13019904,"private_vendor_ad_id":null,"address_info":"Haikkoonlammenrinne 17","area_description_info":null,"attachments_info":null,"attachments_url":null,"antenna_system_info":null,"apartment_number":null,"availability_info":"sopimuksen mukaan","balcony_info":null,"bathroom_appliance_info":"Pesutilojen kuvaus: Tilava pesuhuone jossa poreamme ja kaksi sadesuihkua Varustus: poreamme, lattial\u00e4mmitys, suihku. Erillisen WC:n kuvaus: alakerrassa kaksi wc:t\u00e4, yl\u00e4kerrassa my\u00f6s suihku Varustus: lattial\u00e4mmitys, lattiakaivo.","build_year_info":"2011","building_extra_info":null,"building_override_apartment_house_company":null,"building_override_apartment_sizes_total":null,"building_override_apartments":null,"building_override_building_material_info":"puu, kivi","building_override_building_plan_info":null,"building_override_building_plan_situation":"Asemakaava","building_override_building_subtype":null,"building_override_building_type":4,"building_override_business_premises":null,"building_override_business_premises_sizes_total":null,"building_override_core_type":null,"building_override_exterior_material_info":null,"building_override_energy_class":"A","building_override_energy_flag":1,"building_override_floors":2,"building_override_heating_method":null,"building_override_location_type":null,"building_override_lot_ownership":1,"building_override_lot_ownership_info":null,"building_override_lot_rent_contract_until":null,"building_override_lot_size":1315,"building_override_price_max":null,"building_override_price_min":null,"building_override_renovation_balcony":null,"building_override_renovation_facade":null,"building_override_renovation_other":null,"building_override_renovation_pipe":null,"building_override_renovation_roof":null,"building_override_renovation_window":null,"building_override_renovation_yard":null,"building_override_roof_material_info":"peltikate","building_override_roof_type_info":"Harjakatto","building_override_rooms_max":null,"building_override_rooms_min":null,"building_override_size_max":null,"building_override_size_min":null,"building_override_superintendent":null,"building_override_technical_information":null,"building_override_total_size":null,"building_override_transfer_limitations":null,"building_override_usage":null,"building_override_ventilation":null,"cable_tv_charge":null,"cable_tv_charge_unit":null,"car_storage_info":null,"car_storage_unit":null,"car_storage_cost":null,"buyer_costs":null,"building_rights_unit":null,"comment":null,"condition_inspection_info":null,"common_areas_info":null,"completion_time":null,"condition_info":"Hyv\u00e4","connections_info":"Linja-autopys\u00e4kille n. 400m, Porvoon keskustaan n. 8km, moottoritieliittym\u00e4\u00e4n n. 5km, Helsingin keskustaan ajoaika n. 50 minuuttia.","contact_email":"stina.ahlfors@scasi.fi","contact_email_2":null,"contact_email_3":null,"contact_address":null,"contact_name":"Stina Ahlfors","contact_person_picture_url":"http:\/\/img.cromet.fi\/itemimages\/suppliercont\/www\/209.1248\/img274001.jpg","contact_phone":"040-5830570","contact_show":null,"contract_date":null,"description":"Uudella Lasaretin alueella Haikkoossa vuonna 2011 valmistunut laadukas ja tilava omakotitalo, omalla n. 1315m\u00b2 tontilla. Sijainti on alueella mit\u00e4 parhain, olohuoneesta ja terassilta n\u00e4kym\u00e4t kattojen yli jopa merelle saakka.  Jylh\u00e4, kallioinen tontti rajoittuu pihan  puolelta kaupungin puistoalueeseen. \nTalo on rakennettu kahteen kerrokseen, Sis\u00e4\u00e4ntulokerroksessa saunaosasto pukeutumishuonein, oleskeluhuone, p\u00e4\u00e4makuuhuone jonka yhteydess\u00e4 oma  wc, kodinhoitohuone, vaatehuone , tekninen tila sek\u00e4 lis\u00e4ksi erillinen wc.  Toinen kerros avautuu avarana ja valoisana, olohuone, ruokailutila ja keitti\u00f6 sulavasti yhten\u00e4ist\u00e4 suurta tilaa. Saarekkeellisessa Domuksen tyylikk\u00e4\u00e4ss\u00e4  keitti\u00f6ss\u00e4 on reilusti kaappi- ja laskutilaa ja kokkia ilahduttaa keraamisen lieden oheen asennettu pieni kaasuliesi. Ruokailun tai olohuoneessa oleskelun lomassa voi nauttia tunnelmallisesta kiertoilmatakan tulesta ja l\u00e4mm\u00f6st\u00e4.  T\u00e4st\u00e4 tilasta k\u00e4ynti terassille jossa tilaa grillailuun ja ruokailuun. \nT\u00e4ss\u00e4 kerroksessa viel\u00e4 kolme makuuhuonetta sek\u00e4 erillinen wc jossa my\u00f6s suihku. \nRakennusvaiheessa on otettu huomioon asuinmukavuuksia lis\u00e4\u00e4vi\u00e4 seikkoja, mm. makuuhuoneiden seiniss\u00e4 on tuplakoolaus ja v\u00e4liovet ovat \u00e4\u00e4nt\u00e4 erist\u00e4v\u00e4t.  Todella nopea valokuituyhteys sek\u00e4 talon kattava WLAN helpottaa my\u00f6s kotona ty\u00f6skentely\u00e4. Lattiapinnat asuinhuoneissa kest\u00e4v\u00e4\u00e4 julkisentilan laminaattia, kosteissa tiloissa sek\u00e4 keitti\u00f6ss\u00e4 laattaa. Tilavassa kylpyhuoneessa kaksi sadesuihkua sek\u00e4 poreamme.  L\u00e4mm\u00f6nl\u00e4hteen\u00e4 edullinen maal\u00e4mp\u00f6, kaikissa tiloissa vesikiertoinen lattial\u00e4mmitys. Ilmanvaihto on l\u00e4mm\u00f6ntalteenottava j\u00e4\u00e4hdytysmahdollisuudella. Taloon johtavat ulkoportaat ovat l\u00e4mmitett\u00e4v\u00e4t.\nTontilla my\u00f6s l\u00e4mmityspistokkein varustettu  kahden auton katos jonka yl\u00e4puolella puolil\u00e4mmint\u00e4 varastotilaa n. 31m\u00b2, sek\u00e4 terassi  n. 25m\u00b2.\nPihapiiri on pengerretty, helppohoitoinen, ainutlaatuiseksi tontin tekee upeat kalliot.  Omalta tontilta p\u00e4\u00e4see suoraan vaihtelevamaastoiselle kuntopolulle johon talvisin tehd\u00e4\u00e4n hiihtolatu. Ymp\u00e4rist\u00f6ss\u00e4 my\u00f6s hyv\u00e4t py\u00f6r\u00e4tiet sek\u00e4 venepaikkoja l\u00e4hettyvill\u00e4.  Linja-autopys\u00e4kki n. 400metrin p\u00e4\u00e4ss\u00e4 Haikon kartanolla, omalla autolla Helsingin keskustaan n. 50 minuutissa.","description_supplementary":null,"direction_info":null,"direction_window_info":null,"driving_instructions":null,"electricity_consumption_average":null,"electricity_consumption_annual":null,"electricity_consumption_unit":null,"encumbrances_info":null,"estate_ownership_type":0,"estate_premises_and_profits":null,"estate_tax":"973","financial_fee":null,"financing_offer_1_fee":null,"financing_offer_1_percentage":null,"financing_offer_1_price":null,"financing_offer_2_fee":null,"financing_offer_2_percentage":null,"financing_offer_2_price":null,"floor_location":"2\/2","floor_material_info":"Lattia: Keitti\u00f6ss\u00e4: laatta. Pesutiloissa: laatta. Erillisess\u00e4 WC:ss\u00e4: laatta. Olohuoneessa: laminaatti. Makuuhuoneessa: laminaatti. Saunassa: laatta. Kodinhoitohuoneessa: laatta. Sein\u00e4t: Keitti\u00f6ss\u00e4: maalattu. Pesutiloissa: kaakeli. Erillisess\u00e4 WC:ss\u00e4: kaakeli, maalattu. Olohuoneessa: maalattu. Makuuhuoneessa: maalattu. Saunassa: puu.","foundation_info":null,"grounds_info":null,"heating_cost":null,"heating_info":"maal\u00e4mp\u00f6, veskikiertoinen lattial\u00e4mmitys","hobby_possibilities":null,"honoring_clause":null,"housing_company_name":null,"hunting_right":null,"kitchen_appliance_info":"Kuvaus: Avokeitti\u00f6ss\u00e4 laadukkaat Domuksen kaapistot, kaksi apteekkarinkaappia, paljon ty\u00f6skentely- ja laskutilaa. Keraamisen lieden lis\u00e4ksi pieni kaasuliesi. Liesi: kaasu, keraaminen. Kylm\u00e4s\u00e4ilytys: j\u00e4\u00e4kaappi, pakastin. Varustus: liesituuletin, astianpesukone.","lease_holder":null,"lift_info":null,"link_text":null,"living_area_info":null,"living_area_type":null,"lot_fee":null,"lot_rent":null,"lot_repurchase_price":null,"inquiries":null,"maintenance_fee":null,"management_charge":null,"management_method_info":null,"mode_of_financing":null,"more_info_text":null,"mortgages_info":null,"municipal_development_info":null,"new_apartment_reserved":null,"other_appliances":null,"other_buildings_info":null,"other_fees_info":"Muut maksut: s\u00e4hk\u00f6n kulutus kokonaisuudessaan n. 142 euroa kuukaudessa sis\u00e4lt\u00e4ensek\u00e4 talouss\u00e4hk\u00f6n ett\u00e4 l\u00e4mmityksen.","other_premises":null,"ownership_type":null,"parking_fee":null,"parking_space_info":null,"partner_paper":0,"price_sell":570000,"publish_purchase_price":null,"real_estate_id":null,"renovation_bathroom":null,"renovation_future_info":null,"renovation_info":null,"renovation_kitchen":null,"renovation_other":null,"rent_income_monthly":null,"rent_term_info":null,"rented":null,"sanitation_info":null,"road_costs":null,"sauna_fee":null,"sauna_info":"Kuvaus: Saunassa vuolukivikiuas s\u00e4hk\u00f6kiuas","sell_comments":null,"sell_date":null,"sell_type":null,"sender_node":"KIVI-1248","services_info":"Palvelut: L\u00e4hikauppa Hamarissa n. 2,5km, uusi p\u00e4iv\u00e4koti Haikkoon alueella n. 1km, kouluja Tolkkisissa n. 2,5km, Hamarissa n. 2 km ja Gammelbackassa n. 5km. N\u00e4sin S-market n.6,5km. Todella monipuoliset urheiluharrastusmahdollisuudet ja uimala n.6,5km","sewage_and_water_info":null,"sewer_system_info":null,"share_of_debt_70":null,"share_of_debt_85":null,"share_of_liabilities":null,"shore_direction":null,"shore_length":null,"shore_info":null,"shores_description_info":null,"show_lead_form":null,"size_floor":244,"size_total":244,"storage_info":"vaatehuone, ulkovarasto","use_of_water":null,"vista_info":null,"virtual_presentation_text":null,"virtual_presentation_url":null,"water_fee":null,"water_fee_info":null,"waters":null,"waters_info":null,"yard_direction":null,"yard_info":null,"district_info":"Haikkoo","city_info":"Porvoo","zip_code_info":"06400"},"additionalInfo":{"card_id":13019904,"apartment_city_plan_id":null,"appliances_internet":null,"appliances_bedroom":null,"appliances_livingroom":null,"appliances_nonincluded":null,"appliances_other":null,"appliances_tv":null,"background_image":null,"background_color":null,"city_area_id":null,"contact_person_title":null,"contact_person_rating":null,"contact_person_degrees":null,"contact_person_some_url":null,"contact_person_some":null,"estate_name":null,"estate_info":null,"floor_bathroom":null,"floor_bedroom":null,"floor_kitchen":null,"floor_livingroom":null,"other_materials":null,"other_spaces":null,"postal_area_id":null,"parking_space_type":null,"parking_space_heated":null,"parking_space_electricity":null,"redemption_price":null,"shore_direction":null,"shore_length":null,"site_rent_end":null,"start_of_use_year":null,"terrace":null,"ventilation_system":null,"vrk_id":null,"vrk_apartment_id":null,"wall_bathroom":null,"wall_bedroom":null,"wall_kitchen":null,"wall_livingroom":null},"medias":[{"media_id":147766110,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766113,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766116,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766119,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766122,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766125,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766128,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766131,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766134,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766137,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766140,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766143,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766146,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766149,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766152,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766155,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766158,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766161,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766164,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766167,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766170,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766173,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766176,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766179,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766182,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766185,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766188,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766191,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766194,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1},{"media_id":147766197,"user_id":63236,"name":null,"mimetype":"image\/jpeg","processor_type":1,"status":1}],"building":{"building_id":11418552,"building_class":1,"primary_address_id":11418549,"build_year":2011,"building_type":4,"location_type":1,"floors":2,"lift":0,"sauna":0,"apartments":1,"size_min":152,"size_max":152,"status":1,"vrk_id":"102718731E"},"district":{"district_id":1024546,"city_id":319,"name":"Tuntematon kaupunginosa","status":1},"address":{"address_id":11418549,"street_id":6644783,"street_number":"17","building_letter":null,"zip_code_id":256315,"status":1},"city":{"city_id":319,"county_id":4,"name":"Porvoo","status":1},"street":{"street_id":6644783,"city_id":319,"name":"Haikkoonlammenrinne","status":1,"name_swe":"Haikotr\u00e4skbranten"},"company":{"company_id":5012759,"oikotie_company_id":5096},"oikotieCompany":{"ID":5096,"MARKETING_NAME":"Scasi Oy Lkv","EXTERNAL_ID":"KIVI-1248","TRADE_REGISTRY_NUMBER":"1467377-5","COMPANY_STATUS":"ACTIVE","COMPANY_TYPE":"REAL ESTATE AGENT","STREET_ADDRESS":"Mannerheiminkatu 1","ZIP_CODE":"06100","CITY":"Porvoo","COUNTY":"It\u00e4-Uusimaa","IS_FOREIGN_COMPANY":0,"EMAIL_ADDRESS":"scasi@scasi.fi","LEAD_EMAIL_ADDRESS":null,"PHONE_NUMBER":"040-5830570","FAX_NUMBER":null,"MAP_COORDINATE_LAT":"3426237","MAP_COORDINATE_LON":"6698829","PARENT_COMPANY_ID":null,"PARENT_COMPANY_NAME":null,"CHANGED_DATE":"2013-01-15 10:56:24","HAS_LISTLOGO":1,"HAS_CONTRACT":1,"HAS_ADGUARANTEE":1,"IS_SELF_REGISTERED":0,"IS_CREDITABLE":1,"HAS_FREESPEE":1,"SELLER_ID":null},"coordinates":null,"viewings":[],"logo1":"http:\/\/asunnot.oikotie-static.edgesuite.net\/240*40\/388\/146\/logo\/3881465.jpg","logo2":"http:\/\/asunnot.oikotie-static.edgesuite.net\/240*40\/399\/810\/logo\/3998103.jpg","zipCode":{"zip_code_id":256315,"city_id":319,"zip_code":"06400","name":"Porvoo","status":1}}
      END_OF_STRING

      stub_request(:get, /.13019904./).to_return(body: canned_answer, headers: { 'Content-Type' => "text/json" })

      response = OtApi.getCard(13019904);

      expect(response["card_id"]).to eq("13019904")
      expect(response["ad"]["building_id"]).to eq(11418552)
    end
  end

end