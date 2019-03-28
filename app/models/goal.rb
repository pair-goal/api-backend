class Goal < ApplicationRecord
  belongs_to :user_nickname_id, class_name: "User", foreign_key: "user_nickname"
  belongs_to :partner_nickname_id, class_name: "User", foreign_key: "partner_nickname"
  has_many :diarys, class_name: "Diary", foreign_key: "goal_id"

  validate :title,
    presence: true,
    length: { max: 64 }
  validate :start_date,
    presence: true
  validate :end_date,
    presence: true
  validate :user_nickname,
    presence: true,
    length: { max: 20 }
  validate :partner_nickname,
    presence: true,
    length: { max: 20 }
end
