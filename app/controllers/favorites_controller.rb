class FavoritesController < ApplicationController
    
    def index
        favorites = Favorite.all
        render json: favorites
    end

    def create 
        Favorite.find_or_create_by(user_id: params[:user_id], drink_id: params[:drink_id])
    end

    def delete
       favorite = Favorite.find_by(id: params[:id])
       favorite.destroy
       render json: {message:'Favorite has been successfuly deleted.'}
    end
end
##