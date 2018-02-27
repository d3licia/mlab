# This will guess the User class
FactoryGirl.define do
  factory :message, class: Hash do
    id { Time.now.to_i }
    thread { Time.now.to_i }
    op { false }
    board 'b'
    subject { Faker::Lorem.sentence }
    name { Faker::Internet.user_name }
    content { Faker::Lorem.paragraphs }
    # creation { Faker::Date.between(2.days.ago, Date.today) }
  end
  initialize_with { attributes }
end
