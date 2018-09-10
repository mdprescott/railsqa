class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_user_post

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = @user.id

    respond_to do |format|
      if @comment.save
        if @answer.nil?
          format.html { redirect_to user_question_path(@user, @question), notice: 'Comment was successfully created.' }
        else
          format.html { redirect_to user_question_answer_path(@user, @question, @answer), notice: 'Comment was successfully created.' }
        end
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        if @answer.nil?
          format.html { redirect_to user_question_path(@user, @question), notice: 'Comment was successfully updated.' }
        else
          format.html { redirect_to user_question_answer_path(@user, @question, @answer), notice: 'Comment was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      if @answer.nil?
        format.html { redirect_to user_question_path(@user, @question), notice: 'Comment was successfully deleted.' }
      else
        format.html { redirect_to user_question_answer_path(@user, @question, @answer), notice: 'Comment was successfully deleted.' }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_user_post
      @user = User.find(params[:user_id])
      @question = Question.find(params[:question_id])
      if params[:answer_id].nil?
        @post = Question.find(params[:question_id])
      else
        @answer = Answer.find(params[:answer_id])
        @post = Answer.find(params[:answer_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
