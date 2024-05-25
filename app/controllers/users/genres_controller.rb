class Users::GenresController < ApplicationController

  def index
    @genres = Genre.all
  end
  
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end
  
  
private
  
  def genre_params
    params.require(:genre).permit(:name)
    
  end

  
end