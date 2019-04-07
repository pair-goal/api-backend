class GoalController < ApplicationController
  before_action :auth_user

  def index
    doing, offset, limit = params.values_at :doing, :offset, :limit
    doing = doing == "true" ? true : false

    @goals = Goal.where(is_doing: doing).offset(offset).limit(limit)

    render "index.json", status: 200
  end

  def create
    params.require(:goal).permit(:title, :category, :startDate, :endDate)
    title, category, start_date, end_date = params.values_at :title, :category, :startDate, :endDate

    goal = Goal.new({
      title: title,
      user_id: User.where(id: get_id_from_token).first,
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
    id = params[:id]
    @goal = Goal.where(id: id).first

    render "show.json", status: 200
  end

  def update
    id, title, category, start_date, end_date = params.values_at :id, :title, :category, :startDate, :endDate
    goal = Goal.where(id: id).first

    if(goal.update({title: title, category_num: category, start_date: start_date, end_date: end_date}))
      head 204
    else
      head 405
    end
  end

  def destroy
  end
end
