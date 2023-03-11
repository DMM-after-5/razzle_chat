FactoryBot.define do
    # パスワードの設定
  password = Faker::Internet.password(min_length: 6, max_length: 8)
  
  # ユーザーモデルのダミーデータ
  factory :user do
    name { Faker::Internet.username(specifier: 5..8) }
    nickname { Faker::Internet.username(specifier: 5..8) }
    email { Faker::Internet.email(domain: 'example') }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
    password { password }
    password_confirmation { password }
    is_deleted { "false" }
  end
end