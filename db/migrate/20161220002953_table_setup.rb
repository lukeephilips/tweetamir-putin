class TableSetup < ActiveRecord::Migration[5.0]
  def change
    create_table(:emojis) do |t|
      t.column(:unicode, :string)
      t.column(:description, :string)
    end
    create_table(:keywords) do |t|
      t.column(:keyword, :string)
      t.column(:emoji_id, :integer)
    end
  end
end
