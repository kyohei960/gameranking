class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|

      t.integer :game_comments,   null: false
      t.string  :title,           null: false
      t.string  :body,            null: false
      t.timestamps
    end
  end
end