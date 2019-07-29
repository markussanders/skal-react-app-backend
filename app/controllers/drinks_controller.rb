class DrinksController < ApplicationController

    def index
        drinks = Drink.all
        render json: drinks
    end

    def show 
        drink = Drink.find_by(id: params[:id])
        render json: drink
    end

    private
    
    def update
        drink = Drink.find_by(id: params[:id])
        drink.update(favorited_count: params[:favorited_count])
        render json: drink
    end


end
