class CardMapper

  def mapCard(cardData)
    card = Card.find_or_initialize_by id: cardData[:card_id]
    if cardData[:coordinates]
      handleCoordinates card, cardData
    end
    if cardData[:street] && cardData[:address] && cardData[:city]
      handleLocations card, cardData
    end
    if cardData[:medias]
      handleMedia card, cardData
    end
    if cardData[:adExtra]
      handleSeller card, cardData
    end
    if cardData[:ad] && cardData[:adExtra]
      handleFeatures card, cardData
    end

    card.save
  end

  private

  def handleCoordinates(card, cardData)
    coordinates = Coordinate.find_or_initialize_by card_id: card.id
    coordinates.latitude = cardData[:coordinates][:latitude] unless cardData[:coordinates][:latitude].blank?
    coordinates.longitude = cardData[:coordinates][:longitude] unless cardData[:coordinates][:longitude].blank?
    coordinates.save
  end

  def handleLocations(card, cardData)
    location = Location.find_or_initialize_by card_id: card.id

    address = [
      cardData[:street][:name].to_s + " " + cardData[:address][:street_number].to_s + " " + cardData[:address][:building_letter].to_s,
      cardData[:city][:name].to_s
    ].map {|s| s.strip}.reject {|s| s.blank?}.join(', ')

    location.address = address unless address.blank?
    location.save
  end

  def handleMedia(card, cardData)
    cardData[:medias].each{|media|
      url = "http://asunnot.oikotie-static.edgesuite.net/623*464/#{media[:media_id].to_s[0..2]}/#{media[:media_id].to_s[3..5]}/wide/#{media[:media_id].to_s}.jpg"
      Medium.find_or_create_by card_id: card.id, url: url
    }
  end

  def handleSeller(card, cardData)
    seller = Seller.find_or_initialize_by name: cardData[:adExtra][:contact_name]
    seller.image = cardData[:adExtra][:contact_person_picture_url] unless cardData[:adExtra][:contact_person_picture_url].blank?
    seller.email = cardData[:adExtra][:contact_email] unless cardData[:adExtra][:contact_email].blank?
    seller.company = cardData[:oikotieCompany][:MARKETING_NAME] unless (!cardData[:oikotieCompany] || cardData[:oikotieCompany][:MARKETING_NAME].blank?)
    seller.logo = cardData[:logo1] unless cardData[:logo1].blank?
    if seller.save
      card.seller_id = seller.id
    end
  end

  def handleFeatures(card, cardData)
    adFeatures = {
      price: cardData[:ad][:price],
      size: cardData[:ad][:size],
      title: cardData[:ad][:title],
      description: cardData[:adExtra][:description]
    }

    adFeatures.each{|type, value| 
      if value.present?
        feature = Feature.find_or_initialize_by card_id: card.id, feature: type
        feature.value = value
        feature.save
      end
    }
  end
end
