class TeamsController < ApplicationController
  def show
    @team = Team.friendly.find(params[:slug])
  end
end
