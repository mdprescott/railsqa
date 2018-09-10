require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }

  describe "users#index" do
    it "renders index page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "users#show" do
    it "renders show page" do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "users#new" do
    it "renders new page" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "users#edit" do
    it "renders edit page" do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "users#create" do
    it "creates new user" do
      user_params = FactoryBot.attributes_for(:user)
      expect{ post :create, :params => {user: user_params} }.to change(User, :count).by(1)
      expect(response).to redirect_to(user_questions_url(assigns(:user)))
    end
  end

  describe "users#update" do
    it "updates user" do
      put :update, :params => {
        user:
        {
          name: "Michael Prescott",
          email: "michael@instacart.com"
        } ,
       id: user.id }
      user.reload
      expect(user.name).to eql "Michael Prescott"
      expect(user.email).to eql "michael@instacart.com"
      expect(response).to redirect_to(assigns(:user))
      end
    end

  describe "users#destroy" do
    it "deletes user" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_url)
    end
  end
end
