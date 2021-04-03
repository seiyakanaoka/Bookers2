class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    if comment.save
      #redirect_back(fallback_location: book_path(@book))
    else
      @book_comment = BookComment.new
      @books = Book.new
      @book = Book.find(params[:book_id])
      @user = @book.user
      render :'books/show'
    end
  end

  def destroy
  #  @book = Book.find(params[:book_id])
  @destroied = BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy.id
    #redirect_back(fallback_location: book_path(params[:book_id]))
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
