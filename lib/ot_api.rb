class OtApi

  def self.getCards(params)
    url = "https://asunnot.oikotie.fi/api/cards"
    response = HTTParty.get "#{url}?#{URI::encode_www_form(params)}"
    response.parsed_response
  end

  def self.getCard(id)
    url = "https://asunnot.oikotie.fi/myytavat-asunnot/#{id}?format=json"
    response = HTTParty.get url
    response.parsed_response
  end
end