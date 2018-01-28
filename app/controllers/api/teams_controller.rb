class Api::TeamsController < ApplicationController
  before_action :require_api_user

  def create
    data = JSON.parse(request.body.read)
    return head(:not_acceptable) unless data['players'].present?

    name = data['team'].presence || "Team #{Team.count + 1}"
    team = Team.new(name: name, average_sr: data['average'])

    unless team.save
      return render json: team.errors, status: :unprocessable_entity
    end

    data['players'].each do |player_data|
      TeamPlayer.create_from(player_data, team: team)
    end

    head :created
  end
end
