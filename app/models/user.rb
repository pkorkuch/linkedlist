class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  # just want email to contain @ symbol with 1+ characters before and after it
  # email confirmation will actually confirm the email is correct
  validates :email, format: { with: /.+@.+/i }

  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  has_secure_password
  attr_accessor :remember_token

  has_many :link_posts, dependent: :destroy
  has_many :bookmarks
  has_many :bookmarked_link_posts, through: :bookmarks, source: :link_post

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def activated?
    return false if activated_at.nil?

    true
  end

  def activation_token
    to_signed_global_id(expires_in: 5.minutes, for: 'account_activation')
  end

  def activate(activation_token)
    return self unless activated_at.nil?

    user = GlobalID::Locator.locate_signed(activation_token, for: 'account_activation')

    return nil if user.nil?
    return nil unless user.is_a?(User)
    return nil unless user == self

    update_attribute(:activated_at, Time.now)

    self
  end

  def self.activate(activation_token)
    user = GlobalID::Locator.locate_signed(activation_token, for: 'account_activation')
    return nil if user.nil?
    return nil unless user.is_a?(User)

    user.activate(activation_token)
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.hex(16)
  end
end
