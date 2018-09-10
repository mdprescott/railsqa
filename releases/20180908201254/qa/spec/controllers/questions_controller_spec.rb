require 'rails_helper'


RSpec.describe QuestionsController, type: :controller do
  let(:user) { create :user }
  let(:question) { create :question, user: user }

  describe "questions#index" do
    it "renders index page" do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "questions#show" do
    it "renders show page" do
      get :show, params: { user_id: user.id, id: question.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "questions#new" do
    it "renders new page" do
      get :new, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "questions#edit" do
    it "renders edit page" do
      get :edit, params: { user_id: user.id, id: question.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "questions#create" do
    it "creates new question" do
      question_params = FactoryBot.attributes_for(:question)
      expect{ post :create, :params => {question: question_params, user_id: user} }.to change(Question, :count).by(1)
      expect(response).to redirect_to(user_question_url(assigns(:user), assigns(:question)))
    end
  end

  describe "questions#update" do
    it "updates question" do
      put :update, :params => {
        question:
        {
          title: "Question Title edit",
          body: "Question Body edit"
        } ,
        user_id: user.id,
        id: question.id }
      question.reload
      expect(question.title).to eql "Question Title edit"
      expect(question.body).to eql "Question Body edit"
      expect(response).to redirect_to(user_question_url(assigns(:question)))
      end
    end

  describe "questions#destroy" do
    it "deletes questions" do
      delete :destroy, params: { user_id: user.id, id: question.id }
      expect(response).to redirect_to(user_questions_url)
    end
  end
end
