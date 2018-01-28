FactoryGirl.define do
  factory :user do
    battletag { "cheshire#{User.count}#1234" }
    provider 'bnet'
    uid '1234'
    platform 'pc'
    region 'us'
  end
end
