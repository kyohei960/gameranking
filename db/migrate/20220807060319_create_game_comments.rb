class CreateGameComments < ActiveRecord::Migration[6.1]
  def change
    create_table :game_comments do |t|

      t.timestamps
    end
  end
end
