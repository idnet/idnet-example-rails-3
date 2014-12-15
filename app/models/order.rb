class Order < ActiveRecord::Base
  validates :amount, :currency, :usage, :timestamp, :status, :user_id, presence: true
  validates :currency, inclusion: {in: ['EUR', 'USD']}
  validates :amount, inclusion: {in: (0...10_000_000)}

  before_validation :set_timestamp
  before_save :set_timestamp
  attr_protected :timestamp, :merchant_id, :user_id, :transaction_unique_id

  belongs_to :user

  def hsign
    @hsign ||= ::HSign::Digest.new(APP_CONFIG[:app_secret])
  end

  def to_hmac
    hash = {
      merchant_id: APP_CONFIG[:app_id],
      amount: amount.to_s,
      currency: currency,
      usage: usage,
      transaction_id: id.to_s,
      timestamp: timestamp.to_i.to_s
    }.with_indifferent_access
    hash.merge(hmac: hsign.sign(hash))
  end

  def set_timestamp
    self.timestamp = Time.now if timestamp.blank?
  end

  def callback_verified?(params)
    unless hsign.verify?(params)
      logger.error "HMAC verification failed"
      return false
    end
    return same_transaction?(params)
  end

  def same_transaction?(params)
    transaction = params.with_indifferent_access
    unless transaction["timestamp"].to_i == timestamp.to_i
      logger.error "Tmiestamp mismatch"
      return false
    end

    unless transaction["transaction_id"].to_i == id
      logger.error "Id  mismatch"
      return false
    end

    return true
  end
end
