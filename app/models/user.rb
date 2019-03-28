class User < ApplicationRecord
  has_many :goals_users, ->(user) { unscope(where: :nickname).where("user_nickname=? OR partner_nickname=?", user.nickname, user.nickname)}, class_name: "Goal"

  validates :nickname,
    presence: true,
    length: { maximum: 20 }
  validates :password,
    presence: true,
    length: { minimum: 8, maximum: 16 }
  validates :description,
    length: { maximum: 255 }
end
