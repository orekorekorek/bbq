require 'rails_helper'

RSpec.describe "Users::OmniauthCallbacks", type: :request do
  describe "GET /vkontakte" do
    it "returns http success" do
      get "/users/omniauth_callbacks/vkontakte"
      expect(response).to have_http_status(:success)
    end
  end

end
