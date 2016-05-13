FactoryGirl.define do
    factory :card do
        id 13057713
        active 1
    end
    factory :coordinates do
        latitude 60.248058842634
        longitude 24.81496194372
    end
    factory :feature do
        feature 'price'
        value '2322223'
    end
end