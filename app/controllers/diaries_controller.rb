# frozen_string_literal: true

class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: %i[edit update destroy]
  before_action :set_diaries, only: %i[index]
  before_action :set_calendar_diaries, only: %i[index]

  def index; end

  def new
    @diary = current_user.diaries.build(date: params[:date])
  end

  def edit; end

  def create
    @diary = current_user.diaries.find_by(date: diary_params[:date]) ||
             current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path,
                  notice: I18n.t('messages.created', model: model_name)
    else
      render :new
    end
  end

  def update
    if @diary.update(diary_params)
      redirect_to diaries_path,
                  notice: I18n.t('messages.updated', model: model_name)
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_path,
                notice: I18n.t('messages.destroyed', model: model_name)
  end

  def auto_save
    @diary = current_user.diaries
                         .find_or_initialize_by(date: diary_params[:date])
    @diary.body = diary_params[:body]
    if @diary.save
      head 200
    else
      head 400
    end
  end

  private

  def set_diaries
    @diaries = current_user.diaries.order(date: :desc).page(params[:page])
  end

  def set_calendar_diaries
    date = if params[:start_date]
             Date.parse(params[:start_date])
           else
             Date.today.beginning_of_month
           end
    @calendar_diaries = current_user.diaries.month(date)
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
