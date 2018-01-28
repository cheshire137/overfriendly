class OverwatchApi
  include HTTParty
  base_uri 'ow-api.herokuapp.com'

  def initialize(user)
    @user = user
  end

  def profile
    resp = self.class.get("/profile/#{@user.platform}/#{@user.region}/#{@user.to_param}")
    resp.parsed_response if resp.success?
  end

  def stats
    resp = self.class.get("/stats/#{@user.platform}/#{@user.region}/#{@user.to_param}")
    resp.parsed_response if resp.success?
  end
end
