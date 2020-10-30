class ShipmentsController < ApplicationController
  def index
    @shipments = Shipment.all
  end

  def new
    @shipment =  Shipment.new
  end

  def create
    @shipment = current_user.shipments.new(shipment_params)
    @shipment.update_status_and_description
    if @shipment.save
      flash[:notice] = 'You have successfully registered a shipment.'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def shipment_params
    params.require(:shipment).permit(:carrier, :tracking_number)
  end
end
