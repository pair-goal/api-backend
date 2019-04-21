require 'test_helper'

class DiaryTest < ActiveSupport::TestCase
  test "diary valid save" do
    diary = Diary.new({
      goal_id: Goal.where(id: 1).first.id,
      comment: "success!",
      score: 5,
      date: "20190421"
    })

    assert diary.save, "Failed to save"
  end

  test "find diary test" do
    diary = Diary.where(id: 1).first

    assert_instance_of Diary, diary, "diary is not instance of Diary"
    assert_equal diaries(:one).comment, diary.comment
  end
end
