class IncomingMovementsController < ApplicationController
  def index
    @incoming_movements = IncomingMovement.all
  end

  def show
    # render :text => params
    @incoming_movement = IncomingMovement.find(params[:id])
  end

  def new
    @incoming_movement = IncomingMovement.new
  end

  def products
    respond_to do |format|
      format.json{render :json => Product.all.to_json(:only=>[:id, :description])}
    end
  end

  def first_movement
    @incoming_movement = IncomingMovement.new
    @products = Product.all
  end

  def get_item
    @product = Product.find(params[:id])
    respond_to do |format|
     format.js{}
    end
  end

  def add_same_product
    # render :text => params
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end


  def create
    if params[:incoming_movement].nil?
      incoming_movement = IncomingMovement.create
    else
      incoming_movement = IncomingMovement.create(incoming_movement_params)
    end
    params[:quantities].each do |quantity|
      if quantity[:quantity] != ''
        incoming_movement.incoming_amounts.create(incoming_amount_params(quantity))
      end
    end
    redirect_to incoming_movements_path
  end
  private
  def incoming_amount_params(my_params)
    my_params.permit(:quantity, :product_id, :expiration_date)
  end

  def incoming_movement_params
    params.require(:incoming_movement).permit(:movement_type, :supplier)
  end
end
