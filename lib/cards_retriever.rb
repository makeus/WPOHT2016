class CardsRetriever

  def initialize(api, mapper)
    @api = api
    @mapper = mapper
    raise "invalid api" unless (@api.respond_to? 'getCards') && (@api.respond_to? 'getCard')
    raise "invalid mapper" unless (@mapper.respond_to? 'mapCard')
  end

  def createCardsFromRemote(params)
    cards = @api.getCards(params)
    cards.each {|card|
      @mapper.mapCard @api.getCard(card[:id])
    }
  end 

  private 

end