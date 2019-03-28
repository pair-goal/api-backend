class User < ApplicationRecord
  has_many :goals_users, class_name: "Goal",
    ->(user) { unscope(where: :nickname)
    .where("user_nickname_id=? OR partner_nickname_id=?", user.nickname, user.nickname)}

  validates :nickname,
    presence: true,
    length: { max: 20 }
  validates :password,
    presence: true,
    length: { min: 8, max: 16 }
  validates :description,
    length: { max: 255 }
end
