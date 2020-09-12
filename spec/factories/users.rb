FactoryBot.define do
  factory :user do
    nickname {Faker::Games::Zelda.character}
    family_name {Gimei.last.kanji}
    first_name {Gimei.first.kanji}
    family_name_kana {Gimei.last.katakana}
    first_name_kana {Gimei.last.katakana}
    birth {Faker::Number.number(digits: 8)}
    email {Faker::Internet.free_email}
    password {"Pass1234"}
    password_confirmation {"Pass1234"}
  end
end
