# frozen_string_literal: true

class Shipment < ApplicationRecord
  belongs_to :user

  validates_presence_of :tracking_number, :carrier, :status, :description

  def update_status_and_description
    status_i = search_info.status
    description_i = search_info.events.first.description
    update(status: status_i, description: description_i)
  end

  def search_info
    fedex.track(tracking_number: tracking_number).first
  end

  private

  def fedex
    @fedex ||= Fedex::Shipment.new(key: 'O21wEWKhdDn2SYyb',
                                   password: 'db0SYxXWWh0bgRSN7Ikg9Vunz',
                                   account_number: '510087780',
                                   meter: '119009727',
                                   mode: 'development')
  end
end
