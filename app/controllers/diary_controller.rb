class DiaryController < ApplicationController
  before_action :auth_user

  def show
    id = params[:id]
    @diary = Diary.where(id: id).first

    render "show.json", status: 200
  end

  def update
    id, score, comment = params.values_at :id, :score, :comment
    diary = Diary.where(id: id).first

    if(diary.update({score: score, comment: comment}))
      head 204
    else
      head 405
    end
  end
end
