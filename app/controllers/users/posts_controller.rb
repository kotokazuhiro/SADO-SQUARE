class Users::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to users_post_path(@post.id)
    else
      render :new
    end
  end  

  def index
    if params[:genre_search]
      @posts = Post.genre_search(params[:genre_search])
    else
       @posts = Post.all
    end
     
  end
  
  def search
    @section_title = "「#{params[:search]}」の検索結果"
    @posts = if params[:search].present?
              Post.where(['title ? OR content ?',
                         "%#{params[:search]}%", "%#{params[:search]}%"])
            else
              Post.none
            end
  end
  

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to users_posts_path
  end
  
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :genre_id, :place, :content, :image)
  end
  
end
