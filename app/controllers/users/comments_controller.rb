class Users::CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to users_post_path(@post)
    else
      render "posts/show"
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to users_post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
