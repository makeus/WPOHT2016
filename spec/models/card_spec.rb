require 'rails_helper'

RSpec.describe Card, type: :model do

  describe "with valid params" do
    it "id" do
      expect {Card.create({
        id: '12354353'
        })}.to change(Card, :count).by(1)
    end
  end
  describe "#get_feature_value" do
     let!(:card) { FactoryGirl.create :card }
     let!(:feature) { FactoryGirl.create :feature, card: card }

     it "should return nil for unset feature" do
        expect(Card.create().get_feature_value('asdadsads')).to eq(nil)
     end

     it "should return value for the feature" do
        expect(card.get_feature_value(feature.feature)).to eq(feature.value)
     end
  end

  describe "#modified_recently" do
    it "should be true when created today" do
      card = Card.create({
        id: '12354353'
        });
      expect(card.modified_recently).to eq(true)
    end

    it "should be true when modified today" do
      card = Card.create({
        id: '12354353',
        created_at: 1.days.ago,
        updated_at: 10.minutes.ago
        });
      expect(card.modified_recently).to eq(true)
    end

    it "should be false when created yesterday" do
      card = Card.create({
        id: '12354353',
        updated_at: 5.days.ago,
        created_at: 1.days.ago
        });
      expect(card.modified_recently).to eq(false)
    end

    it "should be false when modified yesterday" do
      card = Card.create({
        id: '12354353',
        created_at: 1.days.ago,
        updated_at: 1.days.ago
        });
      expect(card.modified_recently).to eq(false)
    end

    it "unitilized should be false" do
      card = Card.new({
        id: '12354353'
        });
      expect(card.modified_recently).to eq(false)
    end
  end
end
