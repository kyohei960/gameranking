class RemoveGameCommentsFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :game_comments, :integer
  end
end
