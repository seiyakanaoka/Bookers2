class UsersController < ApplicationController
  
  before_action :baria_user, only: [:edit, :destroy, :update]
  
  def index
    @book = Book.new
    @users = User.page(params[:page]).reverse_order
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @books = @books.page(params[:page]).reverse_order
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
       
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def baria_user
    unless User.find(params[:id]) == current_user.id
           redirect_to user_path(current_user.id)
  end
  
  end

end
