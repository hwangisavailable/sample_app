class User < ApplicationRecord
  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true, length: { maximum: Settings.user_name_length_max }
  validates :email, presence: true, length: { maximum: Settings.user_email_length_max },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: Settings.user_password_length_min }

  has_secure_password
end
