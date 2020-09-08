FactoryBot.define do
  factory :brand do
    name {Faker::Games::Zelda.character}
  end
end
