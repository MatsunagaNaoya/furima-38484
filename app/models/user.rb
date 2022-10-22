class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  with_options presence: true do
    validates :nickname, :birth_date
    validates :last_name, :first_name, format: { with: /\A[ぁ-んーァ-ン一-龥々]/ }
    validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  end
  validates :password, :password_confirmation, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
end
