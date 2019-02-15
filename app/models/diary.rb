class Diary < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :encrypted_body, presence: true
end
