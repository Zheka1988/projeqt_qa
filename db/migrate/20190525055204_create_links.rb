class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      # t.reference :question,
      # t.belongs_to :question, foreign_key: true
      t.belongs_to :linkable, polymorphic: true
      t.timestamps
    end
  end
end
