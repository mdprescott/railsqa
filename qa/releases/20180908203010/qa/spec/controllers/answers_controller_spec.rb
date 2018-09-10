require 'rails_helper'


RSpec.describe AnswersController, type: :controller do
  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let(:answer) { create :answer, question: question, user: user }

  describe "answers#index" do
    it "renders index page" do
      get :index, params: { user_id: user.id, question_id: question.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "answers#show" do
    it "renders show page" do
      get :show, params: { user_id: user.id, question_id: question.id, id: answer.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "answers#new" do
    it "renders new page" do
      get :new, params: { user_id: user.id, question_id: question.id, id: answer.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "answers#edit" do
    it "renders edit page" do
      get :edit, params: { user_id: user.id, question_id: question.id, id: answer.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "answers#create" do
    it "creates new answer" do
      answer_params = FactoryBot.attributes_for(:answer)
      expect{ post :create, :params => {answer: answer_params, question_id: question, user_id: user} }.to change(Answer, :count).by(1)
      expect(response).to redirect_to(user_question_answer_url(assigns(:user), assigns(:question), assigns(:answer)))
    end
  end

  describe "answers#update" do
    it "updates answer" do
      put :update, :params => {
        answer:
        {
          body: "Answer Body edit"
        } ,
        user_id: user.id,
        question_id: question.id,
        id: answer.id }
      answer.reload
      expect(answer.body).to eql "Answer Body edit"
      expect(response).to redirect_to(user_question_answer_url(assigns(:answer)))
      end
    end

  describe "questions#destroy" do
    it "deletes questions" do
      delete :destroy, params: { user_id: user.id, question_id: question.id, id: answer.id }
      expect(response).to redirect_to(user_question_answers_url)
    end
  end
end
