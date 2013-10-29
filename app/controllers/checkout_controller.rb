class CheckoutController < ApplicationController

  def index
    hash = { merchant_id: APP_CONFIG[:app_id],
             amount: Forgery::Monetary.money(min: 10, max: 100),
             currency: 'EUR',
             usage: Forgery::Name.company_name,
             transaction_id: SecureRandom.hex,
             timestamp: Time.now.to_s }.with_indifferent_access
    @params = hash.merge hmac: hsign.sign(hash)
  end

  def show
    if hsign.verify?(order_params.merge(_hmac: params[:hmac]).with_indifferent_access)
      render text: "Order was updated Status: #{params[:status]} - Usage: #{params[:usage]} - Amount: #{params[:amount]} - Id: #{params[:transaction_unique_id]}", status: 200
    else
      render text: 'Hmac is not valid', status: 404
    end
  end

  private

  def order_params
    params.slice(:amount, :currency, :usage, :status, :timestamp, :transaction_unique_id)
  end

  def hsign
    @hsign ||= HSign::Digest.new(APP_CONFIG[:app_secret])
  end

end
