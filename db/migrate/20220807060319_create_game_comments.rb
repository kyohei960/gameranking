class CreateGameComments < ActiveRecord::Migration[6.1]
  def change
    create_table :game_comments do |t|

      t.integer :user_id,              null: false
      t.integer :game_id,              null: false
      t.float   :star,                 null: false, default: 0
      t.string  :game_comment,         null: false
      t.timestamps
    end
  end
end
