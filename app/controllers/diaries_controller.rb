# frozen_string_literal: true

class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: %i[show edit update destroy]
  before_action :set_diaries
  before_action :set_calendar_diaries

  def index; end

  def show; end

  def new
    @diary = current_user.diaries.build(date: params[:date])
  end

  def edit; end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path, notice: I18n.t('messages.created', model: model_name)
    else
      render :new
    end
  end

  def update
    if @diary.update(diary_params)
      redirect_to diaries_path, notice: I18n.t('messages.updated', model: model_name)
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_path, notice: I18n.t('messages.destroyed', model: model_name)
  end

  private

  def set_diaries
    @diaries = current_user.diaries.order(date: :desc).page(params[:page])
  end

  def set_calendar_diaries
    date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    @calendar_diaries = current_user.diaries
                                    .where(date: (date - 1.month)..(date + 1.month))
                                    .order(date: :desc)
  end

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def model_name
    I18n.t('activerecord.models.diary')
  end

  def diary_params
    params.require(:diary).permit(:body, :date)
  end
end
