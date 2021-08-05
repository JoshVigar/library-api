class CreatePodcasts < ActiveRecord::Migration[6.0]
  def change
    create_table :podcasts do |t|
      t.integer :episodes
      t.integer :episode_length

      t.timestamps
    end
  end
end
