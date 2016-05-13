class CardsController < ApplicationController
  def index
      retriever = CardsRetriever.new OtApi.new, CardMapper.new;
      retriever.createCardsFromRemote({cardType: 100, limit: 24, offset: 0})
  end

  def show
    @card = Card.includes(:coordinates, :media, :locations, :features, :seller).find(params[:id])
    props = {}.merge(@card.as_json)
    props[:images] = @card.media.map{|medium| medium.url }
    props[:coordinates] = @card.coordinates.first
    props[:seller] = @card.seller
    props[:title] = @card.features.find_by(feature: "title").value
    props[:description] = @card.features.find_by(feature: "description").value
    props[:authenticityToken] = form_authenticity_token
    render component: 'Card', props: props, prerender: true
  end
end
