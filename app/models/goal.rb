class Goal < ApplicationRecord
  belongs_to :user_nickname_id, class_name: "User", foreign_key: "user_nickname"
  belongs_to :partner_nickname_id, class_name: "User", foreign_key: "partner_nickname"
  has_many :diarys, class_name: "Diary", foreign_key: "goal_id"

  validates :title,
    presence: true,
    length: { maximum: 64 }
  validates :start_date,
    presence: true
  validates :end_date,
    presence: true
  validates :user_nickname,
    presence: true,
    length: { maximum: 20 }
  validates :partner_nickname,
    presence: true,
    length: { maximum: 20 }
end
