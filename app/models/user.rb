class User < ApplicationRecord
  has_secure_password
  has_many :goals_users, ->(user) { unscope(where: :id).where("user_id=? OR partner_id=?", user.id, user.id)}, class_name: "Goal"

  validates :nickname,
    presence: true,
    length: { maximum: 20 }
  validates :password,
    presence: true,
    length: { minimum: 8, maximum: 16 }
  validates :description,
    length: { maximum: 255 }
end
