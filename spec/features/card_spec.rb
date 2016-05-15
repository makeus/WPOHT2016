require 'rails_helper'

describe "Card page" do
    before :all do
        self.use_transactional_fixtures = false
        WebMock.allow_net_connect!
        Rails.cache.clear
    end

    before :each do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.start
    end

    after :each do
        DatabaseCleaner.clean
    end

    after :all do
        Rails.cache.clear
        WebMock.disable_net_connect!(:allow => %r{127.0.0.1:7055/hub/session})
        self.use_transactional_fixtures = true
    end

    before :each do
        seller = FactoryGirl.create :seller
        @card = FactoryGirl.create :card, seller: seller
        FactoryGirl.create :feature, card: @card
        FactoryGirl.create :coordinate, card: @card
        FactoryGirl.create :location, card: @card
        FactoryGirl.create :medium, card: @card
    end

    it "should see map, address and contact form", :js => true do
        visit card_path Card.first
        expect(page).to have_text "TestStreet 12"
        expect(page).to have_text "232 222 €"
        expect(page).to have_selector ".map"
        expect(page).to have_selector ".contact form"
    end

    describe "contact form" do 

        it "should notify of success when entering valid information", :js => true do
            visit card_path Card.first
            fill_in 'contact[name]', :with => 'Testname'
            fill_in 'contact[email]', :with => 'test@email.com'
            fill_in 'contact[message]', :with => 'Testmessage'
            click_button "Send"
            expect(page).to have_text 'Contact message was successfully sent'
            expect(Contact.count).to eq(1)
        end

        it "should notify of failure when entering invalid information", :js => true do
            visit card_path Card.first
            fill_in 'contact[name]', :with => 'Testname'
            click_button "Send"
            expect(page).to have_text 'Specify atleast a phone number or an e-mail address'
        end
    end
end