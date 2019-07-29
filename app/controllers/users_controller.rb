class UsersController < ApplicationController

    def index
        users = User.all
        render json: users
    end
    
    def show 
        user = User.find_by(id: params[:id])
        render json: user
    end

    def new
    end

    def create
        user = User.find_or_create_by(
            name: params[:name], 
            username: params[:username], 
            password: params[:password], 
            age: params[:age], 
            barcart: params[:barcart]
        )
        render json: user
    end

    private

    def update 
        user = User.update(
            name: params[:name], 
            username: params[:username], 
            password: params[:password], 
            age: params[:age], 
            barcart: params[:barcart]
        )
        render json: user
    end

    def delete
        user = User.find_by(id: params[:id])
        user.destroy
        render json: {message: 'You have successfully deleted your account.'}
    end

end