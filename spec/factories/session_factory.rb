FactoryBot.define do
  factory :session do |f|
    f.auth_token SecureRandom.hex(10)
    user
  end
end
