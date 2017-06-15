FactoryGirl.define do
  factory :product do
    sequence :name do |n|
      "Test-Product No. #{n}"
    end
    sequence :price do |n|
      "#{n}.95"
    end
  end
end
