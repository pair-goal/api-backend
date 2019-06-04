class DiaryController < ApplicationController
  before_action :auth_user

  def show
    goal_id, date = params.values_at :goal_id, :date
    @diary = Diary.where(goal_id: goal_id, date: date).first

    if(@diary)
      render "show.json", status: 200
    else
      goal = Goal.where(id: goal_id).first
      render json: goal, status: 200
    end
  end

  def update
    goal_id, date, score, comment = params.values_at :goal_id, :date, :score, :comment
    date = Date.parse(date)
    today = Date.today.strftime("%Y%m%d")

    nickname = User.where(id: get_id_from_token).first.nickname
    conversation_id = Goal.where(id: goal_id).first.conversation_id
    data = {id: conversation_id, comment: comment, score: score, nickname: nickname}.to_json
    $redis.publish 'updateDiary', data
    
    unless(date==Date.today)
      head 405
      return
    end

    if(Diary.exists?(goal_id: goal_id, date: today))
      diary = Diary.where(goal_id: goal_id, date: today).first
      goal = Goal.where(id: diary.goal_id).first

      puts "diary--------------------"
      puts score

      pre_score = diary.score

      score_column = int_to_column(score.to_i)
      pre_score_column = int_to_column(pre_score)
      
      score_num = goal[score_column]
      pre_score_num = goal[pre_score_column]

      if(diary.update({score: score, comment: comment}) && goal.update(score_column => score_num+1, pre_score_column => pre_score_num-1))
        head 201
      else
        head 405
      end
    else
      goal = Goal.where(id: goal_id).first
      last_diary = Diary.where(id: goal.last_diary_id).first

      diary = {
        goal_id: goal_id,
        pre_id: last_diary.nil? ? "" : last_diary.id,
        score: score,
        comment: comment,
        date: today
      }

      if(saved_diary = Diary.create(diary))
        goal.update(last_diary_id: saved_diary.id)

        if last_diary.nil?
          head 201
          return
        end

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

  def int_to_column(number)
    case number
      when 0 then return :zero_score
      when 1 then return :one_score
      when 2 then return :two_score
      when 3 then return :three_score
      when 4 then return :four_score
      when 5 then return :five_score
    end
  end
end
