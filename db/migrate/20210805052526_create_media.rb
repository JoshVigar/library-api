class CreateMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :media do |t|
      t.string :title
      t.string :link
      t.references :streamable, polymorphic: true, null: false, index: {
        name: :index_media_on_streamable
      }

      t.timestamps
    end
  end
end
