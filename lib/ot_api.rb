class OtApi

  def getCards(params)
    url = "https://asunnot.oikotie.fi/api/cards"
    parsePrice(params)
    parseLocation(params)
    response = HTTParty.get "#{url}?#{URI::encode_www_form(params)}"
    response.parsed_response.with_indifferent_access
  end

  def getCard(id)
    url = "https://asunnot.oikotie.fi/myytavat-asunnot/#{id}?format=json"
    response = HTTParty.get url
    response.parsed_response.with_indifferent_access
  end

  private
  def parsePrice(params)
    if params[:price]
      params['price[max]'] = params[:price][:max] unless !params[:price][:max]
      params['price[min]'] = params[:price][:min] unless !params[:price][:min]
    end
    params.delete(:price)
    params
  end

  def parseLocation(params)
    if params[:location]
      locations = params[:location].inject([]) {|locations, location|
        case location
        when 'FI'
          locations.push('[1,9,"Suomi"]')
        when 'SE'
          locations.push('[679888,9,"Ruotsi"]')
        end
      }
      params[:locations] = '[' + locations.join(',') + ']'
    end

    params.delete(:location)
    params
  end
end