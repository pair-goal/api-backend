class GoalController < ApplicationController
  before_action :auth_user

  def index
    doing, offset, limit = params.values_at :doing, :offset, :limit
    doing = doing == "true" ? true : false

    @goals = Goal.where(is_doing: doing).offset(offset).limit(limit)
  end

  def create
    params.require(:goal).permit(:title, :category, :startDate, :endDate)
    title, category, start_date, end_date = params.values_at :title, :category, :startDate, :endDate

    goal = Goal.new({
      title: title,
      user_nickname: User.where(nickname: get_nickname_from_token).first,
      category_num: category,
      start_date: start_date,
      end_date: end_date
    })

    if goal.save
      head 201
    else
      head 405
    end
  end

  def show
  end

  def update
  end

  def destroy
  end
end
