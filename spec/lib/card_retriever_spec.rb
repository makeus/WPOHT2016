require 'rails_helper'

describe "CardRetriever" do
  describe "#initialize" do
    it "should raise error if api is invalid" do
      apimock = double("api")
      mappermock = double("mapper")
      expect{CardsRetriever.new apimock, mappermock}.to raise_error(RuntimeError)
    end
  end

  describe "#createCardsFromRemote" do
    it "expepct call api with given params and with each result call mapper" do
      apimock = double("api")
      apimock.stub(:getCards){ {cards: [{id: 1}, {id: 2}] }}
      apimock.stub(:getCard){ {card: 1} }

      apimock.should_receive(:getCards).once
      apimock.should_receive(:getCard).twice

      mappermock = double("mapper")
      mappermock.stub(:mapCard)
      mappermock.should_receive(:mapCard).twice

      retriever = CardsRetriever.new apimock, mappermock

      params = {
        cardType: 100
      }
      retriever.createCardsFromRemote params
    end
  end

end