class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :set_calendar_diaries

  def index
    @diaries = current_user.diaries.order(date: :desc).page(params[:page])
  end

  def show
  end

  def new
    @diary = current_user.diaries.build(date: params[:date])
  end

  def edit
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to @diary, notice: 'Diary was successfully created.'
    else
      render :new
    end
  end

  def update
    if @diary.update(diary_params)
      redirect_to @diary, notice: 'Diary was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_url, notice: 'Diary was successfully destroyed.'
  end

  private
    def set_calendar_diaries
      date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
      @calendar_diaries = current_user.diaries
                                      .where(date: (date - 1.week)..(date + 1.week))
                                      .order(date: :desc)
    end

    def set_diary
      @diary = current_user.diaries.find(params[:id])
    end

    def diary_params
      params.require(:diary).permit(:body, :date, :user_id)
    end
end
