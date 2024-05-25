class Users::NicesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @nice = current_user.nices.new(post_id: @post.id)
    @nice.save
    redirect_to users_post_path(@post)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @nice = current_user.nices.find_by(post_id: @post.id)
    @nice.destroy
    redirect_to users_post_path(@post)
  end
  
end
