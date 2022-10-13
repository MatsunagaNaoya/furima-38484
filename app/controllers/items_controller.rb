class ItemsController < ApplicationController
  def index
    #    @users = User.all
  end

  def new
    #    @user = User.new
  end

  #  def create
  #    @user = User.create(user_params)
  #    if @user.save
  #      redirect_to root_path
  #    else
  #      render :new
  #    end
  #  end

  #  private

  #  def user_params
  #    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :first_name_kana, :last_name_kana, :birthday)
  #  end
end
