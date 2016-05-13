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
    props[:title] = get_feature_value "title"
    props[:description] = get_feature_value "description"
    props[:price] = helper.number_to_currency(get_feature_value("price"), unit: '€', delimiter: ' ', precision: 0, format: "%n %u") 
    props[:size] = get_feature_value "size"
    props[:location] = @card.locations.first
    props[:authenticityToken] = form_authenticity_token
    render component: 'Card', props: props, prerender: true
  end

  private

  def get_feature_value(name)
     feature = @card.features.find_by(feature: name)
     if !feature.nil?
        return feature.value
     end
  end

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end
end
