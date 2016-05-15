FactoryGirl.define do
    factory :card do
        id '13057713'
        active 1
    end
    factory :coordinate do
        latitude 60.248058842634
        longitude 24.81496194372
    end
    factory :feature do
        feature 'price'
        value '232 222 €'
    end
    factory :location do
        address 'TestStreet 12'
    end
    factory :medium do
        url 'http://asunnot.oikotie-static.edgesuite.net/623*464/149/729/wide/149729181.jpg'
    end

    factory :seller do
        name 'Test Seller'
        company 'TEst company'
    end
end