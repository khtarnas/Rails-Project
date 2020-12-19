require 'pry'
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
  end

  def change_status
    user = User.find(params[:user])
    bool = params[:bool]
    link = '/users/' + params[:user]
    respond_to do |format|
      if bool == 'true'
        if user.update(:admin => true)
          format.html { redirect_to link, notice: 'User was successfully made an admin.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render users }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        if user.update(:admin => false)
          format.html { redirect_to link, notice: 'User was successfully made a member (no longer an admin).' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render users }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
