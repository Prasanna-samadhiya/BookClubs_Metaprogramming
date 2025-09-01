class BookclubsController < ApplicationController
  def index
    @bookclub = Bookclub.new
    @bookclubs = Bookclub.all
  end

  def action
    bookclub = params[:id].present? ? Bookclub.find_by(id: params[:id]) : nil
    result   = BookclubHelper.dispatch(params[:do], self, bookclub)

    if result[:redirect]
      redirect_to result[:redirect], notice: result[:notice], alert: result[:alert]
    elsif result[:render]
      render result[:render]
    else
      head :bad_request
    end
  end

  private

  def bookclub_params
    params.require(:bookclub).permit(:name)
  end
end






# Controller without the metaprogamming
#------------------------------------------------------------------------------------------------------------------------------------------
# class BookclubsController < ApplicationController
#   before_action :set_bookclub, only: [ :destroy ]

#   def index
#     @bookclubs = Bookclub.all
#   end

#   def show
#     @bookclub = Bookclub.find(params[:id])
#     @users = @bookclub.users
#   end

#   def create
#     @bookclub = Bookclub.new(bookclub_params)
#     if @bookclub.save
#       redirect_to bookclubs_path, notice: "Bookclub Created"
#     else
#       @bookclubs = Bookclub.all  # ensure this is set again for rendering index
#       render :index, status: :unprocessable_entity
#     end
#   end

#     def join
#       @bookclub = Bookclub.find(params[:id])

#       if current_user.bookclubs.include?(@bookclub)
#         redirect_to bookclubs_path, alert: "You are already a member!"
#       else
#         current_user.bookclubs << @bookclub
#         redirect_to bookclubs_path, notice: "You joined #{@bookclub.name}!"
#       end
#     end

#     def leave
#       @bookclub = Bookclub.find(params[:id])
#       current_user.bookclubs.delete(@bookclub)
#       redirect_to bookclubs_path, notice: "You left #{@bookclub.name}."
#     end

#   def destroy
#     @bookclub.destroy
#     redirect_to bookclubs_path, notice: "Bookclub Deleted"
#   end

#   private

#   def set_bookclub
#     @bookclub = Bookclub.find(params[:id])
#   end

#   def bookclub_params
#     params.require(:bookclub).permit(:name)
#   end
# end
#------------------------------------------------------------------------------------------------------------------------------------------