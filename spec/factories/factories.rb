FactoryBot.define do

  factory :client do
    last_name { "Jordan" }
    email {"michaeljordan@gmail.com"}
    phone {"0606060606"}
    address {"TopofTheWorld"}
    post_code {"99999"}
    city {"Lakers"}
    segment {"particulier"}
    role {"client"}
    password {"thebestever"}
    amap {"Non-membre"}
  end
end
