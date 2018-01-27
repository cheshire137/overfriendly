class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:bnet]

  validates :battletag, uniqueness: true
  validates :provider, uniqueness: { scope: :uid }

  def to_param
    battletag.split('#').join('-')
  end
end
