require 'paypal-sdk-merchant'
class PaypalInterface < ActiveRecord::Base
  attr_reader :api, :express_checkout_response

  PAYPAL_RETURN_URL = Rails.application.routes.url_helpers.paid_orders_url(host: 'localhost:3000')
  PAYPAL_CANCEL_URL = Rails.application.routes.url_helpers.revoked_orders_url(host: 'localhost:3000')
  PAYPAL_NOTIFY_URL = Rails.application.routes.url_helpers.ipn_orders_url(host: 'localhost:3000')

  def initialize(order)
    @api = PayPal::SDK::Merchant::API.new
    @order = order
  end
  
  def express_checkout
    @set_express_checkout = @api.build_set_express_checkout({
      SetExpressCheckoutRequestDetails: {
        ReturnURL: PAYPAL_RETURN_URL,
        CancelURL: PAYPAL_CANCEL_URL,
        PaymentDetails: [{
          NotifyURL: PAYPAL_NOTIFY_URL,
          OrderTotal: {
            currencyID: "USD",
            value: 1
          },
          ItemTotal: {
            currencyID: "USD",
            value: 1
          },
          ShippingTotal: {
            currencyID: "USD",
            value: "0"
          },
          TaxTotal: {
            currencyID: "USD",
            value: "0"
          },
          PaymentDetailsItem: [{
            Name: 1,
            Quantity: 1,
            Amount: {
              currencyID: "USD",
              value: 1
            },
            ItemCategory: "Physical"
          }],
          PaymentAction: "Sale"
        }]
      }
    })

    # Make API call & get response
    @express_checkout_response = @api.set_express_checkout(@set_express_checkout)

    # Access Response
    #if @express_checkout_response.success?
    #  @order.set_payment_token(@express_checkout_response.Token)
    #else
    #  @express_checkout_response.Errors
    #end
  end
  
  def get_express_checkout
    # Build request object
    @get_express_checkout_details = @api.build_get_express_checkout_details({})

    # Make API call & get response
    @get_express_checkout_details_response = @api.get_express_checkout_details(@get_express_checkout_details)

    # Access Response
    if @get_express_checkout_details_response.success?
      @get_express_checkout_details_response.GetExpressCheckoutDetailsResponseDetails
    else
      @get_express_checkout_details_response.Errors
    end
  end
  
  def do_express_checkout
    @do_express_checkout_payment = @api.build_do_express_checkout_payment({
      DoExpressCheckoutPaymentRequestDetails: {
        PaymentAction: "Sale",
        Token: @order.payment_token,
        PayerID: @order.payerID,
        PaymentDetails: [{
          OrderTotal: {
            currencyID: "USD",
            value: 1
          },
          NotifyURL: PAYPAL_NOTIFY_URL
        }]
      }
    })

    # Make API call & get response
    @do_express_checkout_payment_response = @api.do_express_checkout_payment(@do_express_checkout_payment)

    # Access Response
    if @do_express_checkout_payment_response.success?
      details = @do_express_checkout_payment_response.DoExpressCheckoutPaymentResponseDetails
      #@order.set_payment_details(prepare_express_checkout_response(details))
    else
      errors = @do_express_checkout_payment_response.Errors # => Array
      #@order.save_payment_errors errors
    end
  end
end
