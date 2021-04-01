class BooksController < ApplicationController
  def index
    @books = Book.new
    @book = Book.page(params[:page]).reverse_order
    @user = current_user
  end

  def create
    @books = Book.new(book_params)
    @books.user_id = current_user.id
    if @books.save
      redirect_to book_path(@books.id), notice: 'You have created book successfully.'
    else
      @user = current_user
      @book = Book.page(params[:page]).reverse_order
      render :index
    end
  end

  def show
    @book_comment = BookComment.new
    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
