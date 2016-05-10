class ProductsController < ApplicationController
  def index
    # @products = Product.all
    @products = Product.paginate(page: params[:page], per_page: 10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @units = Unit.all
  end

  def edit
    @product = Product.find(params[:id])
    @units = Unit.all
  end

  def create
    # render :text => params
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = 'Producto ingresado con exito'
      redirect_to @product
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = 'El producto se actualizo con exito'
      redirect_to @product
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:part_number,
                                    :description,
                                    :specification,
                                    :unit,
                                    :alert_before,
                                    :photo,
                                    :maximum,
                                    :minimum,
                                    :optimum,
                                    :expiration)
  end
end
