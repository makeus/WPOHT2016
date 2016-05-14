class CardsController < ApplicationController
  def index
    retriever = CardsRetriever.new OtApi.new, CardMapper.new;
    props = retriever.createCardsFromRemote({
      "cardType" => 100,
      "limit" => 12,
      "offset" => 0,
      "price" => {
        "min" => 1000000
      }
    }.deep_merge(card_params).with_indifferent_access);

    props[:cards] = props[:cards].map{|card| {
      :id => card.id,
      :price => card.get_feature_value("price"),
      :size => card.get_feature_value("size"),
      :address => card.locations.first.address,
      :image => card.media.first.url,
      :features => {
        :pool => card.get_feature_value("pool"),
        :car => card.get_feature_value("garage"),
        :sea => card.get_feature_value("shore"),
        :sauna => card.get_feature_value("sauna"),
      }
      }}

    render component: 'SearchResult', props: props, prerender: true
  end

  def show
    @card = Card.includes(:coordinates, :media, :locations, :features, :seller).find(params[:id])
    props = {}.merge(@card.as_json)
    props[:images] = @card.media.map{|medium| medium.url }
    props[:coordinates] = @card.coordinates.first
    props[:seller] = @card.seller
    props[:title] = @card.get_feature_value "title"
    props[:description] = @card.get_feature_value "description"
    props[:price] = helper.number_to_currency(@card.get_feature_value("price"), unit: '€', delimiter: ' ', precision: 0, format: "%n %u") 
    props[:size] = @card.get_feature_value "size"
    props[:location] = @card.locations.first
    props[:authenticityToken] = form_authenticity_token
    render component: 'Card', props: props, prerender: true
  end

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end

  def card_params
    params.permit(:limit, :offset, :cardType, :price => [:max, :min], :location => [], :features => [])
  end
end
