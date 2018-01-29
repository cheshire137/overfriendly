class Api::TeamsController < ApplicationController
  before_action :require_api_user

  def create
    data = begin
      JSON.parse(request.body.read)
    rescue
      return head(:not_acceptable)
    end
    return head(:not_acceptable) unless data['players'].present?

    name = data['team'].presence || "Team #{Team.count + 1}"
    @team = Team.new(name: name, average_sr: data['average'])

    unless @team.save
      return render json: @team.errors, status: :unprocessable_entity
    end

    team_players = data['players'].map do |player_data|
      TeamPlayer.create_from(player_data, team: @team)
    end

    players_saved = team_players.map(&:persisted?)

    unless players_saved.all?
      @team.destroy
      team_players.map(&:destroy)
      return head(:unprocessable_entity)
    end

    render template: 'api/teams/create', status: :created
  end
end
