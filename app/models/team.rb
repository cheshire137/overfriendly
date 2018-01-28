class Team < ApplicationRecord
  MAX_NAME_LENGTH = 50

  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }

  has_many :players, class_name: 'TeamPlayer', dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

  alias_attribute :to_s, :name
end
