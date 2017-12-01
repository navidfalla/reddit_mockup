class AddTextToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :text, :text
  end
end
