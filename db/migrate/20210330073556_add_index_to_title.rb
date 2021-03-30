class AddIndexToTitle < ActiveRecord::Migration[6.0]
  def change
    add_index(:books, :title)
  end
end
