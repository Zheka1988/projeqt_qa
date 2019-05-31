class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :path
      t.belongs_to :question, foreign_key: true
      t.belongs_to :user, foreign_key: true
      # t.belongs_to :rewardable, polymorphic: true
      t.timestamps
    end
  end
end
