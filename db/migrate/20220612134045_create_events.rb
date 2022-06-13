class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :calendar, null: false, foreign_key: true
      t.date :release_date

      t.timestamps
    end
  end
end
