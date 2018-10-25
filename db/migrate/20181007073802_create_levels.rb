class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.text :level_name
      t.integer :level_order

      t.timestamps null: false
    end
  end
end
