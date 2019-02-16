class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :set_diaries

  def index
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
    def set_diaries
      @diaries = current_user.diaries
    end

    def set_diary
      @diary = current_user.diaries.find(params[:id])
    end

    def diary_params
      params.require(:diary).permit(:body, :date, :user_id)
    end
end
