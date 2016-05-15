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

    props[:cards] = props[:cards].map{|card| 
      cardProps = {
      :id => card.id,
      :price => card.get_feature_value("price"),
      :size => card.get_feature_value("size"),
      :address => card.locations.first.address,
      :features => {
        :pool => card.get_feature_value("pool"),
        :car => card.get_feature_value("garage"),
        :sea => card.get_feature_value("shore"),
        :sauna => card.get_feature_value("sauna"),
      }}
      cardProps[:image] = card.media.first.url unless card.media.first.nil?
      cardProps
    }
    session[:referrer]=url_for(params)
    render component: 'SearchResult', props: props
  end

  def show
    @card = Card.includes(:coordinates, :media, :locations, :features, :seller).find(params[:id])
    props = @card.as_json.merge({
      :coordinates => @card.coordinates.first,
      :seller => @card.seller,
      :title => @card.get_feature_value("title"),
      :description => @card.get_feature_value("description"),
      :price => @card.get_feature_value("price"),
      :size => @card.get_feature_value("size"),
      :location => @card.locations.first,
      :authenticityToken => form_authenticity_token
    })
    props[:images] = @card.media.map{|medium| medium.url }
    if session[:referrer] 
      props[:referrer] = session[:referrer]
    end
    render component: 'Card', props: props
  end

  def card_params
    params.permit(:limit, :offset, :cardType, :price => [:max, :min], :location => [], :features => [])
  end
end
