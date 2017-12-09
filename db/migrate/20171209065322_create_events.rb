class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :finish
      t.string :name, :null => false
      t.references :track, :null => false, foreign_key: true

      t.timestamps
    end
  end
end
