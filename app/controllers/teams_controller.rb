class TeamsController < ApplicationController
  def show
    @team = Team.friendly.find(params[:slug])
    @players = @team.players.includes(:user)
  end
end
