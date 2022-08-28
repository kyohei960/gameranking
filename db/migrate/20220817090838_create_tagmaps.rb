class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.bigint :game_id, null: false, foreign_key: true
      t.bigint :tag_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
