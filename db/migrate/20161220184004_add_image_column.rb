class AddImageColumn < ActiveRecord::Migration[5.0]
  def change
    add_column(:emojis, :image, :string)
  end
end
