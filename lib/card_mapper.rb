class CardMapper

  def mapCard(cardData)
    card = Card.find_or_create_by id: cardData[:id]
    if cardData[:coordinates]
      handleCoordinates card, cardData
    end
    if cardData[:street] && cardData[:address] && cardData[:city]
      handleLocations card, cardData
    end

    if cardData[:medias]
      handleMedia card, cardData
    end
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
      url = "http://asunnot.oikotie-static.edgesuite.net/*/#{media[:id].to_s[0..2]}/#{media[:id].to_s[3..5]}/full/#{media[:id].to_s}.jpg"
      Medium.find_or_create_by card_id: card.id, url: url
    }
  end
end
