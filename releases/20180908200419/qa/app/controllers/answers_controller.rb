class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_user_question
  before_action :set_answer_vote, only: [:upvote, :downvote]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    unless @post.views.where(user_id: @user.id).any?
    @post.views.create(user_id: @user.id)
    end
    @answer.view_count = @post.views.count
    @answer.save
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user_id = @user.id

    respond_to do |format|
      if @answer.save
        format.html { redirect_to user_question_answer_path(@user, @question, @answer), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to user_question_answer_path(@user, @question, @answer), notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to user_question_answers_url(@user, @question), notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    if @post.votes.where(user_id: @user.id).any?
    @vote = @post.votes.where(user_id: @user.id)
    @vote.update(upvote: true)
    else
    @post.votes.create(user_id: @user.id, upvote: true)
    end
    @answer.vote_score = @post.votes.where(upvote: true).count - @post.votes.where(upvote: false).count
    respond_to do |format|
      if @answer.save
        format.html { redirect_to user_question_answer_path(@user, @question, @answer), notice: 'Vote Recorded!' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def downvote
    if @post.votes.where(user_id: @user.id).any?
    @vote = @post.votes.where(user_id: @user.id)
    @vote.update(upvote: false)
    else
    @post.votes.create(user_id: @user.id, upvote: false)
    end
    @answer.vote_score = @post.votes.where(upvote: true).count - @post.votes.where(upvote: false).count
    respond_to do |format|
      if @answer.save
        format.html { redirect_to user_question_answer_path(@user, @question, @answer), notice: 'Vote Recorded!' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_vote
      @answer = Answer.find(params[:answer_id])
      @post = Answer.find(@answer.id)
    end

    def set_answer
      @answer = Answer.find(params[:id])
      @post = Answer.find(@answer.id)
    end

    def set_user_question
      @user = User.find(params[:user_id])
      @question = Question.find(params[:question_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:body)
    end
end
