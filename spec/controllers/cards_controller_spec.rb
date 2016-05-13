require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let!(:card) { FactoryGirl.create :card }

  describe "#show" do
    context "card without relations" do
      it "assigns the requested card as @card" do
        get :show, {:id => card.to_param}
        expect(assigns(:card)).to eq(card)
      end
    end

    context "card with feature relations" do
      let!(:feature) { FactoryGirl.create :feature, card: card }
      
      it "assigns the requested card as @card" do
        get :show, {:id => card.to_param}
        expect(assigns(:card)).to eq(card)
      end
    end
  end
end
