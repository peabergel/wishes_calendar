class CreateEventMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :event_movies do |t|
      t.references :event, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
