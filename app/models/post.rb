class Post < ActiveRecord::Base
  validates :content, {presence: true}

  #ここにリレーションを書くのが一番早い
  #外部キーがpost.content
  #プライマリーキーがwikidataのpost.content
  #wikidataのpost.contentのindexを貼る
  #マイグレーションファイルで貼る
  #　└add,index

  def self.search(content,category_name)
      r = Post.where("id > 0")
      if content && content != ""
        r = r.where(["content LIKE ? or definition LIKE ?","%#{content}%","%#{content}%"])
      end
      if category_name && category_name != ""
          r = r.where("category_name = '#{category_name}'")
      end
      return r
  end


end
