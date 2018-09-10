require 'rails_helper'


RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let(:answer) { create :answer, question: question, user: user }

  describe "comments#edit - question" do
    let(:comment) { create :comment, user: user, post: question }
    it "renders edit page" do
      get :edit, params: { user_id: user.id, question_id: comment.post.id, id: comment.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "comments#edit - answer" do
    let(:comment) { create :comment, user: user, post: answer }
    it "renders edit page" do
      get :edit, params: { user_id: user.id, question_id: comment.post.question.id, answer_id: comment.post.id, id: comment.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "comments#create - question" do
    let(:comment) { build :comment, user: user, post: question }
    it "creates new question comment" do
      comment_params = FactoryBot.attributes_for(:comment)
      expect{ post :create, :params => {comment: comment_params, question_id: comment.post.id, user_id: user} }.to change(Comment, :count).by(1)
      expect(response).to redirect_to(user_question_url(assigns(:user), assigns(:question)))
    end
  end

  describe "comments#create - answer" do
    let(:comment) { build :comment, user: user, post: answer }
    it "creates new question comment" do
      comment_params = FactoryBot.attributes_for(:comment)
      expect{ post :create, :params => {comment: comment_params, question_id: comment.post.question, answer_id: comment.post, user_id: user} }.to change(Comment, :count).by(1)
      expect(response).to redirect_to(user_question_answer_url(assigns(:user), assigns(:question), assigns(:answer)))
    end
  end

  describe "comments#update - question" do
    let(:comment) { create :comment, user: user, post: question }
    it "updates comment" do
      put :update, :params => {
        comment:
        {
          body: "Comment Body edit"
        } ,
        user_id: user.id,
        question_id: comment.post.id,
        id: comment.id }
      comment.reload
      expect(comment.body).to eql "Comment Body edit"
      expect(response).to redirect_to(user_question_url(assigns(:question)))
      end
    end

    describe "comments#update - answer" do
      let(:comment) { create :comment, user: user, post: answer }
      it "updates comment" do
        put :update, :params => {
          comment:
          {
            body: "Comment Body edit"
          } ,
          user_id: user.id,
          question_id: comment.post.question.id,
          answer_id: comment.post.id,
          id: comment.id }
        comment.reload
        expect(comment.body).to eql "Comment Body edit"
        expect(response).to redirect_to(user_question_answer_url(assigns(:question), assigns(:answer)))
        end
      end

  describe "comments#destroy - question" do
    let(:comment) { create :comment, user: user, post: question }
    it "deletes comment" do
      delete :destroy, params: { user_id: user.id, question_id: comment.post.id, id: comment.id }
      expect(response).to redirect_to(user_question_url(assigns(:question)))
    end
  end

  describe "comments#destroy - answer" do
    let(:comment) { create :comment, user: user, post: answer }
    it "deletes comment" do
      delete :destroy, params: { user_id: user.id, question_id: comment.post.question.id, answer_id: comment.post.id, id: comment.id }
      expect(response).to redirect_to(user_question_answer_url(assigns(:question), assigns(:answer)))
    end
  end
end
