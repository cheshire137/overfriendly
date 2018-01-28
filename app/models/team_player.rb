class TeamPlayer < ApplicationRecord
  MAX_NAME_LENGTH = 30
  MAX_BATTLETAG_LENGTH = 30
  MAX_ROLE_LENGTH = 10

  belongs_to :team
  belongs_to :user, required: false

  validates :team, presence: true
  validates :role, length: { maximum: MAX_ROLE_LENGTH }
  validates :name, length: { maximum: MAX_NAME_LENGTH }
  validates :battletag, length: { maximum: MAX_BATTLETAG_LENGTH }
  validate :user_or_battletag_or_name_present

  def self.create_from(data, team:)
    battletag = data['battlenetID']
    user = if battletag.present?
      User.find_by_battletag(battletag)
    end
    team_player_data = { name: data['name'] }
    if data['role'].present?
      team_player_data[:role] = Hero.normalize_roles(data['role'])
    end
    if user
      team_player_data[:user] = user
    elsif battletag.present? && battletag.downcase != 'no-bnet-id'
      team_player_data[:battletag] = battletag
    end
    team.players.create(team_player_data)
  end

  private

  def user_or_battletag_or_name_present
    return if user
    return if battletag.present?
    return if name.present?

    errors.add(:base, 'User, name, or Battletag must be specified.')
  end
end
