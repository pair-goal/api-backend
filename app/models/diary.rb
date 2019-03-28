class Diary < ApplicationRecord
  belongs_to :goal, class_name: "Goal", foreign_key: "goal_id"

  validate :comment,
    presence: true,
    length: { max: 255 }
  validate :score,
    presence: true
end
