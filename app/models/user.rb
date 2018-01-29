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

  DEFAULT_PLATFORM = 'pc'.freeze
  DEFAULT_REGION = 'us'.freeze

  devise :omniauthable, omniauth_providers: [:bnet]

  before_validation :set_region
  before_validation :set_platform

  validates :battletag, uniqueness: true
  validates :provider, uniqueness: { scope: :uid }
  validates :platform, inclusion: { in: VALID_PLATFORMS.keys }, presence: true
  validates :region, inclusion: { in: VALID_REGIONS.keys }, presence: true

  has_and_belongs_to_many :friends, class_name: 'User', join_table: 'friends',
    foreign_key: 'user1_id', association_foreign_key: 'user2_id'

  has_many :team_players
  has_many :teams, through: :team_players

  alias_attribute :to_s, :battletag

  scope :order_by_battletag, ->{ order("LOWER(battletag)") }

  def link_team_players
    TeamPlayer.where(battletag: battletag, user_id: nil).update_all(user_id: id)
  end

  def grant_api_access
    self.api_token = Devise.friendly_token[0,20]
    save
  end

  def self.has_api_access?(battletag, token)
    exists?(battletag: battletag, api_token: token)
  end

  def self.battletag_from_param(str)
    index = str.rindex('-')
    start = str[0...index]
    rest = str[index+1...str.size]
    "#{start}##{rest}"
  end

  def self.parameterize(battletag)
    battletag.split('#').join('-')
  end

  def complete?
    platform.present? && region.present?
  end

  def overwatch_api
    OverwatchApi.new(self)
  end

  def to_param
    self.class.parameterize(battletag)
  end

  private

  def set_region
    self.region ||= DEFAULT_REGION
  end

  def set_platform
    self.platform ||= DEFAULT_PLATFORM
  end
end
