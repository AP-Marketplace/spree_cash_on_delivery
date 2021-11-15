module Spree
  module OrderDecorator
    def cash_on_delivery?
      payments.where(state: ['checkout', 'pending']).map { |m| m.payment_method.type }.include? "Spree::PaymentMethod::CashOnDelivery"
    end
  end
end

::Spree::Order.prepend Spree::OrderDecorator