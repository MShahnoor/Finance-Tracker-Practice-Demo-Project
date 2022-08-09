class UserStocksController < ApplicationController

  def create
    stock = Stock.already_exists(params[:ticker])
    if stock.blank?
      stock = Stock.get_iex_stock(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} successfully added to your Portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user,stock_id: stock.id).first.destroy
    flash[:notice] = "Stock #{stock.name} successfully deleted."
    redirect_to my_portfolio_path
  end

end
