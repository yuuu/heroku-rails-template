# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    redirect_to diaries_path if current_user
  end

  def about; end
end
