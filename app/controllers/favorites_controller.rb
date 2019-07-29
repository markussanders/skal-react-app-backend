class FavoritesController < ApplicationController
    

    def create 
        Favorite.create(user_id: params[:user_id], drink_id: params[:drink_id])
    end

    def delete
       favorite = Favorite.find_by(id: params[:id])
       favorite.destroy
       render json: {message:'Favorite has been successfuly deleted.'}
    end
end
##