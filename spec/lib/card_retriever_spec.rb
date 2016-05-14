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
      mappermock.should_receive(:mapCard).twice { Card.create }

      retriever = CardsRetriever.new apimock, mappermock

      params = {
        cardType: 100
      }
      cards = retriever.createCardsFromRemote params
      expect(cards.kind_of?(Array)).to eq(true)
      expect(cards.length).to eq(2)
    end

    it "should return empty array if api returns nothing" do
      apimock = double("api")
      mappermock = double("mapper")

      apimock.stub(:getCards){}
      apimock.stub(:getCard){}
      mappermock.stub(:mapCard)

      params = {
        cardType: 100
      }

      retriever = CardsRetriever.new apimock, mappermock

      cards = retriever.createCardsFromRemote params
      expect(cards.kind_of?(Array)).to eq(true)
      expect(cards.length).to eq(0)
    end
  end

end