FactoryGirl.define do
  factory :tag do
    sequence :title do |n|
      "crispy_#{n}"
    end
  end
end
