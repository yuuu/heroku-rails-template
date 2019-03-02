class ImportsController < ApplicationController
  def new
    @import = current_user.imports.build
  end

  def create
    @import = current_user.imports.build(import_params)
    if @import.save
      redirect_to diaries_path, notice: I18n.t('messages.created', model: model_name)
    else
      render :new
    end
  end

  private

  def model_name
    I18n.t('activerecord.models.import')
  end

  def import_params
    params.require(:import).permit(:file)
  end
end
