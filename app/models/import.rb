class Import < ApplicationRecord
  attr_accessor :file

  belongs_to :user
  has_many :diaries

  validates :file, presence: true

  before_create :import

  def import
    import_diaries = []
    CSV.foreach(file.tempfile, headers: true) do |row|
      diary = Diary.new(import_id: id, date: row[0], body: row[1], user: user)
      diary.run_callbacks(:save) { false }
      import_diaries << diary
    end
    Diary.import import_diaries
  end
end
