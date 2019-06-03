class CreateVoitings < ActiveRecord::Migration[5.2]
  def change
    create_table :voitings do |t|
      t.integer :like, default: 0
      t.integer :dislike, default: 0
      # t.belongs_to :voitingable, polymorphic: true
      t.belongs_to :users, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.timestamps
    end
  end
end
