class Api::UsersController < ApplicationController
  
  
  def index
    @users = User.all
    render json: @users
  end
  
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def create
    @user = User.new(params[:user])
    
    if @todo.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
end