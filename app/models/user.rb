class User < ApplicationRecord
  has_many :replies, dependent: :destroy
  has_many :vacancies, dependent: :destroy
  has_one :summery, dependent: :destroy

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  validates :email, presence: true,
            uniqueness: {case_sensitive: false}, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  validates :password_digest, length: {minimum: 6}

  has_secure_password


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def create_remember_token
    self.remember_token= User.encrypt User.new_remember_token
  end
end
