class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :find_commentable
  before_action :authenticate_user!, except: [:index, :show]
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
    @comment = current_user.comments.build
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    #@comment = current_user.comments.build(comment_params)
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_back(fallback_location: @commentable) }
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
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
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
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote 
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    redirect_back(fallback_location: @commentable)
  end  
  
  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    redirect_back(fallback_location: @commentable)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, users_attributes: [:id])
    end

    def find_commentable
      @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
      @commentable = Link.find(params[:link_id]) if params[:link_id]
    end
end
