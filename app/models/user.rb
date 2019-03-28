class User < ApplicationRecord
  has_many :goals_users, class_name: "Goal",
    ->(user) { unscope(where: :nickname)
    .where("user_nickname_id=? OR partner_nickname_id=?", user.nickname, user.nickname)}

  validate :nickname,
    presence: true,
    length: { max: 20 }
  validate :password,
    presence: true,
    length: { min: 8, max: 16 }
  validate :description,
    length: { max: 255 }
end
