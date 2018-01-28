class Team < ApplicationRecord
  MAX_NAME_LENGTH = 50

  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }

  has_many :players, class_name: 'TeamPlayer', dependent: :destroy
end
