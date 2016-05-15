require 'rails_helper'

describe "search page" do

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

  it "by default shows atleast one result", :js => true do
    visit root_path
    expect(page).to have_selector ".search-card"
  end

  it "clicking search result brings you to card page", :js => true do
    visit root_path
    expect(page).to have_selector ".search-card"
    first('.search-card').click
    expect(page).to have_selector "#gallery"
  end

  it "pagination should work as expected", :js => true do
    visit root_path
    click_link "Next"
    expect(page).to have_link "Prev"
    expect(page).to have_selector ".search-card"
  end
  
  it "search filtering should work as expected", :js => true do
    visit root_path
    fill_in 'price[min]', :with => '100000000'
    find('label', :text => 'Sweden').click
    click_button "Search"
    expect(page).to have_text "You got 0 results"
  end

end