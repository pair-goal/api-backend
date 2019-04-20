class DiaryController < ApplicationController
  before_action :auth_user

  def show
    goal_id, date = params.values_at :goal_id, :date
    @diary = Diary.where(goal_id: goal_id, created_at: Date.today..Date.today).first

    render "show.json", status: 200
  end

  def update
    goal_id, date, score, comment = params.values_at :goal_id, :date, :score, :comment
    date = Date.parse(date)
    
    unless(date==Date.today)
      head 405
      return
    end

    if(Diary.exists?(goal_id: goal, created_at: Date.today..Date.today))
      diary = Diary.where(goal_id: goal_id, created_at: Date.today..Date.today).first

      if(diary.update({score: score, comment: comment}))
        head 201
      else
        head 405
      end
    else
      last_diary = Goal.where(id: goal_id).first

      diary = Diary.new({
        goal_id: goal_id,
        pre_id: last_diary.id,
        score: score,
        comment: comment
      })

      if(saved_diary = diary.save)
        if(last_diary.update({next_id: saved_diary.id}))
          head 201
        else
          head 405
        end
      else
        head 405
      end
    end
  end
end
