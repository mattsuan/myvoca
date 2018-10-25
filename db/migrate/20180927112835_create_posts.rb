class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      #一意性制約（同じcontentのデータを作らないため）
      t.timestamps null: false
    end
  end
end
