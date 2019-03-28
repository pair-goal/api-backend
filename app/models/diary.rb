class Diary < ApplicationRecord
  belongs_to :goal, class_name: "Goal", foreign_key: "goal_id"

  validates :comment,
    presence: true,
    length: { max: 255 }
  validates :score,
    presence: true
end
