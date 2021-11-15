module Spree
  module ShipmentDecorator
    def determine_state(order)
      return 'canceled' if order.canceled?
      return 'pending' unless order.can_ship?
      return 'pending' if inventory_units.any? &:backordered?
      return 'shipped' if state == 'shipped'
      order.paid? || order.cash_on_delivery? || Spree::Config[:auto_capture_on_dispatch] ? 'ready' : 'pending'
    end
  end
end

Spree::Shipment.prepend Spree::ShipmentDecorator