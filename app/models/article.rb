class Article < ApplicationRecord
  has_many :responses

  def response_url
    "#{Rails.configuration.postmark_inbound_email_hash}+#{self.id}@inbound.postmarkapp.com"
  end
end
