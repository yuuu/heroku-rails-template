# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Diaries', type: :system do
  before do
    @diary = Diary.create!(date: Date.today, body: '本日の日記')
    @user = User.create!(
      email: 'test@example.com',
      password: 'test1234',
      password_confirmation: 'test1234'
    )
    visit new_user_session_path
    expect(page).to have_content 'Log in'
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: 'test1234'
    click_button 'Log in'
  end

  it 'show diary.' do
    visit diaries_path
    expect(page).to have_content '日記一覧'
    find_link(class: ['create_button']).click
    expect(page).to have_content '日記新規登録'
  end
end
