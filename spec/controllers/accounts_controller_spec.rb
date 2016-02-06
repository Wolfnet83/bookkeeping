require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  
  describe "GET #index" do
    login
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "try to access unauthenticated user" do
    it "index redirect to sign in page" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
