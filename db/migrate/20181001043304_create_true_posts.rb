class CreateTruePosts < ActiveRecord::Migration
  def change
    create_table :true_posts do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
