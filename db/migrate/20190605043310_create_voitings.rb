class CreateVoitings < ActiveRecord::Migration[5.2]
  def change
    create_table :voitings do |t|
      t.integer :raiting

      t.belongs_to :user, foreign_key: true
      # t.belongs_to :question, foreign_key: true
      # t.belongs_to :answer, foreign_key: true
      t.belongs_to :voitingable, polymorphic: true
      t.timestamps
    end
  end
end
