class TeamPlayer < ApplicationRecord
  MAX_NAME_LENGTH = 30
  MAX_BATTLETAG_LENGTH = 30
  MAX_ROLE_LENGTH = 10

  belongs_to :team
  belongs_to :user

  validates :team, presence: true
  validates :role, length: { maximum: MAX_ROLE_LENGTH }
  validates :name, length: { maximum: MAX_NAME_LENGTH }
  validates :battletag, length: { maximum: MAX_BATTLETAG_LENGTH }
  validate :user_or_battletag_present

  private

  def user_or_battletag_present
    return if user
    return if battletag.present?

    errors.add(:base, 'User or Battletag must be specified.')
  end
end
