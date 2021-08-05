class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.integer :duration

      t.timestamps
    end
  end
end
