class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = URI.parse(value)
    unless uri.scheme == 'http' || uri.scheme == 'https'
      record.errors.add attribute, (options[:message] || 'is not a HTTP or HTTPS uri')
    end
    record.errors.add attribute, (options[:message] || 'must contain a host') if uri.host.nil?
    record.errors.add attribute, (options[:message] || 'may not contain a username') unless uri.user.nil?
    record.errors.add attribute, (options[:message] || 'may not contain a password') unless uri.password.nil?
    # record.errors.add attribute, (options[:message] || 'may not contain a port') unless uri.port.nil?
  rescue URI::InvalidURIError, URI::InvalidComponentError
    record.errors.add attribute, (options[:message] || 'is not a valid URI')
  end
end

class LinkPost < ApplicationRecord
  validates :link_text, presence: true, length: { maximum: 75 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :link, presence: true, length: { maximum: 2000 }
  validates :link, uri: true
  belongs_to :user
  has_many :bookmarks
  has_many :users, through: :bookmarks

  self.implicit_order_column = 'created_at'

  scope :newest_to_oldest, -> { order(created_at: :desc) }
  scope :newest, -> { newest_to_oldest.first }
end
