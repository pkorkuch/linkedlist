class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  # just want email to contain @ symbol with 1+ characters before and after it
  # email confirmation will actually confirm the email is correct
  validates :email, format: { with: /.+@.+/i }

  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password
end
