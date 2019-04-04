class GoalController < ApplicationController
  before_action :auth_user

  def index
    doing, offset, limit = params.values_at :doing, :offset, :limit
    doing = doing == "true" ? true : false

    @goals = Goal.where(is_doing: doing).offset(offset).limit(limit)
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end
end
