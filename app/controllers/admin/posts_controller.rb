class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:genre_search]
      @posts = Post.genre_search(params[:genre_search])
    else
       @posts = Post.all
    end
     
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  
end
