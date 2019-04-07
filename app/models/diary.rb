class Diary < ApplicationRecord
  belongs_to :goal, class_name: "Goal", foreign_key: "goal_id"
  has_one :pre, class_name: "Diary", foreign_key: "pre_id"
  has_one :next, class_name: "Diary", foreign_key: "next_id"

  validates :comment,
    presence: true,
    length: { maximum: 255 }
  validates :score,
    presence: true
end
