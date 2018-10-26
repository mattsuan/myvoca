class AddPosts < ActiveRecord::Migration
  def change
    add_column :posts, :definition, :text
    add_column :posts, :registration_type, :integer
    add_column :posts, :wiki_data, :text
    add_column :posts, :category_name, :text
    add_column :posts, :category_color, :text
    add_column :wikidata, :post_content, :text
    add_column :categories, :category_color, :text
  end
end
