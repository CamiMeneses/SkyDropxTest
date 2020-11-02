class ShipmentsController < ApplicationController
  def index
    @shipments = current_user.shipments
  end

  def new
    @shipment =  Shipment.new
  end

  def create
    @shipment = current_user.shipments.new

    if shipment_params_empty? && !json_data
      flash[:alert] = 'Por favor revisa la información ingresada'
    elsif json_data
      json_data.each do |shipment|
        create_shipment(shipment)
      end
    else
      create_shipment(shipment_params, json_data)
    end
    render :new
  end

  private

  def create_shipment(shipment, json_data = true)
    @shipment = current_user.shipments.new(shipment)

    begin
      @shipment.update_status_and_description
      if @shipment.save
        flash[:notice] = "Tus envíos se registraron con exito #{shipment ['tracking_number']}"
      end
    rescue
      flash[:alert] = "Hay un problema con el envío #{shipment['tracking_number']}"
    end
  end

  def shipment_params_empty?
    shipment_params[:carrier] == '' || shipment_params[:tracking_number] == '' ? true : false
  end

  def json_data
    return false unless json_params != ''

    begin
      json_data = JSON.parse(json_params)
      return json_data
    rescue
      return false
    else
      return false if json_data.class != Array && json_data.first.class != Hash
    end
  end

  def shipment_params
    params.require(:shipment).permit(:carrier, :tracking_number)
  end

  def json_params
    params[:json_data]
  end
end
