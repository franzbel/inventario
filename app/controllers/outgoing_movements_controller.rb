class OutgoingMovementsController < ApplicationController
  def index
    @outgoing_movements = OutgoingMovement.all
  end

  def show
    # render :text => params
    @outgoing_movement = OutgoingMovement.find(params[:id])
  end

  def new
    @outgoing_movement = OutgoingMovement.new
  end

  def products
    respond_to do |format|
      # format.json{render :json => Product.all.to_json(:only=>[:id, :description])}
      format.json{render :json => TotalQuantity.all.to_json(:only=>[:id, :product_id, :description, :quantity, :expiration_date])}
    end
  end


  def get_item
    @product = TotalQuantity.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    # render :text => params
    outgoing_movement = OutgoingMovement.create(outgoing_movement_params)
    params[:quantities].each do |quantity|
      if quantity[:quantity] != ''
        outgoing_movement.outgoing_amounts.create(outgoing_amount_params(quantity))
      end
    end
    redirect_to outgoing_movements_path
  end

  private
  def outgoing_amount_params(my_params)
    my_params.permit(:quantity, :product_id, :expiration_date)
  end

  def outgoing_movement_params
    params.require(:outgoing_movement).permit(:movement_type, :receiver)
  end
end
