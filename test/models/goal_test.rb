require 'test_helper'

class GoalTest < ActiveSupport::TestCase
  test "goal valid save" do
    goal = Goal.new({
      user_nickname: User.where(nickname: "NoYE").first,
      title: "let's gooooo",
      category_num: 1,
      start_date: DateTime.parse("2019-03-23 14:20:33"),
      end_date: DateTime.parse("2019-03-23 14:20:33")
    })

    assert goal.save, "Failed to save"
  end
end
