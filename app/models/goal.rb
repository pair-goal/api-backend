class Goal < ApplicationRecord
  belongs_to :user_id, class_name: "User", foreign_key: "user_id"
  belongs_to :partner_id, class_name: "User", foreign_key: "partner_id", optional: true
  has_one :last_diary, class_name: "Diary", foreign_key: "last_diary_id"
  has_many :diarys, class_name: "Diary", foreign_key: "goal_id"

  validates :title,
    presence: true,
    length: { maximum: 64 }
  validates :start_date,
    presence: true
  validates :end_date,
    presence: true
end
