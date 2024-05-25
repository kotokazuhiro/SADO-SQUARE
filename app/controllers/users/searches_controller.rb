class Users::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @posts = Post.looks(params[:search], params[:word])
  end
  
  
end