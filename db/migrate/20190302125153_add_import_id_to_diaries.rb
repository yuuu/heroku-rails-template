class AddImportIdToDiaries < ActiveRecord::Migration[5.2]
  def change
    add_reference :diaries, :import, foreign_key: true
  end
end
