class CardMapper

  def mapCard(cardData)
    card = Card.find_or_create_by id: cardData[:id]
    handleCoordinates(card, cardData)
  end

  private

  def handleCoordinates(card, cardData)
    if(cardData[:coordinates])
      coordinates = Coordinate.find_or_initialize_by card_id: card.id
      coordinates.latitude = cardData[:coordinates][:latitude] unless cardData[:coordinates][:latitude].blank?
      coordinates.longitude = cardData[:coordinates][:longitude] unless cardData[:coordinates][:longitude].blank?
      coordinates.save
    end
  end
end
