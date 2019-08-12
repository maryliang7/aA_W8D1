class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post_id)
    end
  end


  def show
    @comment = Comment.find(params[:id])
    @post = Post.find_by(id: @comment.post_id)
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id, :post_id)
  end
end
