class CreateWikidata < ActiveRecord::Migration
  def change
    create_table :wikidata do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
