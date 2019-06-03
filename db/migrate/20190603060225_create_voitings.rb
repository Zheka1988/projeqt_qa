class CreateVoitings < ActiveRecord::Migration[5.2]
  def change
    create_table :voitings do |t|
      t.integer :like
      t.integer :dislike
      t.belongs_to :voitingable, polymorphic: true

      t.timestamps
    end
  end
end
