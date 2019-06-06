require 'aws-sdk-s3'

class GoalController < ApplicationController
  before_action :auth_user

  def index
    doing, offset, limit = params.values_at :doing, :offset, :limit
    doing = doing == "true" ? true : false

    @goals = Goal.where({user_id: get_id_from_token, is_doing: doing}).offset(offset).limit(limit)
    @urls = @goals.map do |goal|
      if goal
        $signer.presigned_url(
          :get_object,
          bucket: 'pair-goal-image',
          key: goal.image_path,
          expires_in: 60*10
        )
      else
        ' '
      end
    end

    render "index.json", status: 200
  end

  def create
    title, category, start_date, end_date, image_path = params.values_at :title, :category_num, :start_date, :end_date, :image_path

    goal = Goal.new({
      title: title,
      user_id: get_id_from_token,
      category_num: category,
      start_date: Date.parse(start_date),
      end_date: Date.parse(end_date)
    })

    if goal.save!
      $redis.select 3
      $redis.lpush category, goal.id

      url  = ''

      if image_path
        key = "goal/#{goal.id}.jpg"

        url = $signer.presigned_url(
          :put_object,
          bucket: 'pair-goal-image',
          key: key,
          expires_in: 60*10
        )

        goal.update(image_path: key)
      end
      
      render status: 201, json: {url: url}
    else
      head 405
    end
  end

  def show
    id = params[:id]
    @goal = Goal.where(id: id).first

    today = Date.today.strftime("%Y%m%d")
    start_date = @goal.start_date
    end_date = @goal.end_date

    zero= @goal.zero_score
    one = @goal.one_score
    two = @goal.two_score
    three = @goal.three_score
    four = @goal.four_score
    five = @goal.five_score

    @goal.update({is_doing: false}) if(today>end_date && @goal.is_doing)

    if(@goal.is_doing)
      @goal.average_score = (one+two*2+three*3+four*4+five*5)/(today.to_i-start_date.to_i)
    else
      @goal.average_score = (one+two*2+three*3+four*4+five*5)/(end_date-start_date).to_i
    end

    user = User.where(id: @goal.partner_id).first
    @goal[:partner_name] = user ? @goal.partner_name : nil

    @url = ''

    if @goal.image_path
      @goal.image_path = $signer.presigned_url(
        :get_object,
        bucket: 'pair-goal-image',
        key: @goal.image_path,
        expires_in: 60*10
      )
    else
      @goal.image_path = ' '
    end

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
    id = params[:id]
    goal = Goal.where(id: id).first

    if(goal.destroy)
      head 204
    else
      head 405
    end
  end
end
