FactoryBot.define do
  factory :order_shipping do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    addresses { '青山1-1' }
    building { '東京ハイツ' }
    phone_number { '09012345678' }
  end
end