class UsersController < ApplicationController

  def index
    @books = Book.new
    @users = User.page(params[:page]).reverse_order
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @book = @user.books
    @booked = @book.page(params[:page]).reverse_order
    @books = Book.new
  end

  def edit
     @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  def follow
    @user = User.find(params[:id])
    @following_users = @user.following_user
  end

  def follower
    @user = User.find(params[:id])
    @follower_users = @user.follower_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
