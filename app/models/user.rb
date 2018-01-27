class User < ApplicationRecord
  VALID_PLATFORMS = {
    'pc' => 'PC',
    'psn' => 'PlayStation',
    'xbl' => 'Xbox'
  }.freeze

  VALID_REGIONS = {
    'us' => 'United States',
    'eu' => 'Europe',
    'kr' => 'South Korea',
    'cn' => 'China',
    'global' => 'Global'
  }.freeze

  devise :omniauthable, omniauth_providers: [:bnet]

  validates :battletag, uniqueness: true
  validates :provider, uniqueness: { scope: :uid }
  validates :platform, inclusion: { in: VALID_PLATFORMS.keys }, allow_nil: true
  validates :region, inclusion: { in: VALID_REGIONS.keys }, allow_nil: true

  def to_param
    battletag.split('#').join('-')
  end
end
