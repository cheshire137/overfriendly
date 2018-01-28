class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_complete

  def index
    @friends = current_user.friends.order(:battletag)
  end
end
