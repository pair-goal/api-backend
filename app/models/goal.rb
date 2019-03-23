class Goal < ApplicationRecord
  belongs_to :user_nickname
  belongs_to :partner_nickname
end
