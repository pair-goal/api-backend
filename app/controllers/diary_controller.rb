class DiaryController < ApplicationController
  before_action :auth_user

  def show
    goal_id, date = params.values_at :goal_id, :date
    @diary = Diary.where(goal_id: goal_id, date: date).first

    if(@diary)
      render "show.json", status: 200
    else
      goal = Goal.where(id: goal_id).first
      render json: goal, status: 206
    end
  end

  def update
    goal_id, date, score, comment = params.values_at :goal_id, :date, :score, :comment
    date = Date.parse(date)
    today = Date.today.strftime("%Y%m%d")
    
    unless(date==Date.today)
      head 405
      return
    end

    if(Diary.exists?(goal_id: goal_id, date: today))
      diary = Diary.where(goal_id: goal_id, date: today).first

      if(diary.update({score: score, comment: comment}))
        head 201
      else
        head 405
      end
    else
      goal = Goal.where(id: goal_id).first
      last_diary = Diary.where(id: goal.last_diary_id).first

      diary = {
        goal_id: goal_id,
        pre_id: last_diary.id,
        score: score,
        comment: comment,
        date: today
      }

      if(saved_diary = Diary.create(diary))
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
