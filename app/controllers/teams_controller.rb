class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_complete, only: [:show]

  def show
    @team = Team.friendly.find(params[:slug])
    @players = @team.players.includes(:user)
  end
end
