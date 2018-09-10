class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_question_vote, only: [:upvote, :downvote]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    unless @post.views.where(user_id: @user.id).any?
    @post.views.create(user_id: @user.id)
    end
    @question.view_count = @post.views.count
    @question.save
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = @user.questions.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to user_question_path(@user, @question), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to user_question_path(@user, @question), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def upvote
    if @post.votes.where(user_id: @user.id).any?
    @vote = @post.votes.where(user_id: @user.id)
    @vote.update(upvote: true)
    else
    @post.votes.create(user_id: @user.id, upvote: true)
    end
    @question.vote_score = @post.votes.where(upvote: true).count - @post.votes.where(upvote: false).count
    respond_to do |format|
      if @question.save
        format.html { redirect_to user_question_path(@user, @question), notice: 'Vote Recorded!' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
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
    @question.vote_score = @post.votes.where(upvote: true).count - @post.votes.where(upvote: false).count
    respond_to do |format|
      if @question.save
        format.html { redirect_to user_question_path(@user, @question), notice: 'Vote Recorded!' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to user_questions_url(@user), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_vote
      @question = Question.find(params[:question_id])
      @post = Question.find(@question.id)
    end

    def set_question
      @question = Question.find(params[:id])
      @post = Question.find(@question.id)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :body)
    end
end
