require 'rails_helper'

RSpec.describe Contact, type: :model do
  
  let!(:card) { FactoryGirl.create :card }

  describe "with valid params" do
    it "email, phone, name and valid card a new contact should be created" do
      expect {Contact.create({
        email: 'test@email.com',
        phone: '050-12345566',
        name: 'testName',
        card_id: card.id
        })}.to change(Contact, :count).by(1)
    end

    it "phone number, name and valid card a new contact should be created" do
      expect {Contact.create({
        phone: '050-12345566',
        name: 'testName',
        card_id: card.id
        })}.to change(Contact, :count).by(1)
    end

    it "email, name and valid card a new contact should be created" do
      expect {Contact.create({
        email: 'test@email.com',
        name: 'testName',
        card_id: card.id
        })}.to change(Contact, :count).by(1)
    end
  end
  describe "with invalid params" do 
    it "no email nor phone, no new contact should be created" do
      expect {Contact.create({
        name: 'testName',
        card_id: card.id
        })}.to change(Contact, :count).by(0)
    end

    it "no name, no new contact should be created" do
      expect {Contact.create({
        phone: '050-12345566',
        email: 'test@email.com',
        card_id: card.id
        })}.to change(Contact, :count).by(0)
    end

  end
end
