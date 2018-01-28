require 'test_helper'

class Api::TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_token = 'abc123'
    @user = create(:user, api_token: @api_token)
  end

  test '400 Bad Request when no token prefix in auth header' do
    json = file_fixture('valid-team-payload.json').read

    post '/api/teams', params: json, headers: {
      'HTTP_AUTHORIZATION' => "#{@user.battletag} #{@api_token}"
    }

    assert_response :bad_request
  end

  test '401 Unauthorized when no auth header given' do
    json = file_fixture('valid-team-payload.json').read

    post '/api/teams', params: json

    assert_response :unauthorized
  end

  test '403 Forbidden when bad auth header given' do
    json = file_fixture('valid-team-payload.json').read

    post '/api/teams', params: json, headers: { 'HTTP_AUTHORIZATION' => 'Token this is bad' }

    assert_response :forbidden
  end

  test 'accepts payload and creates team' do
    json = file_fixture('valid-team-payload.json').read
    auth = "Token #{@user.battletag} #{@api_token}"

    assert_difference 'Team.count' do
      assert_difference 'TeamPlayer.count', 6 do
        post '/api/teams', params: json, headers: { 'HTTP_AUTHORIZATION' => auth }
      end
    end

    assert_response :created
  end
end
