class StocksController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @total_quantities = TotalQuantity.where('product_id == ?', params[:id])
  end
end
