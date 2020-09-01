FactoryBot.define do
  factory :user do
    nickname {Faker::Games::Zelda.character}
    family_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    family_name_kana
    first_name_kana
    birth
    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
  end
end
