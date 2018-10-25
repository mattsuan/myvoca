require 'net/http'
require 'open-uri'
require 'pry'

class PostsController < ApplicationController

  def index
    @posts = Post.where(registration_type: nil).order(created_at: :desc)
    #@wikidatum = Wikidatum.find_by(post_content: params[:content])
    #@wikidata = Wikidata.find_by(word_id: params[:id])
    @amount = Post.where(registration_type: 1).count
    if @amount < 600 && @amount >= 500
      @level = Level.find_by(level_order: 15)
    elsif @amount < 500 && @amount >= 400
      @level = Level.find_by(level_order: 14)
    elsif @amount < 400 && @amount >= 300
      @level = Level.find_by(level_order: 13)
    elsif @amount < 300 && @amount >= 250
      @level = Level.find_by(level_order: 12)
    elsif @amount < 250 && @amount >= 200
      @level = Level.find_by(level_order: 11)
    elsif @amount < 200 && @amount >= 150
      @level = Level.find_by(level_order: 10)
    elsif @amount < 150 && @amount >= 100
      @level = Level.find_by(level_order: 9)
    elsif @amount < 100 && @amount >= 70
      @level = Level.find_by(level_order: 8)
    elsif @amount < 70 && @amount >= 50
      @level = Level.find_by(level_order: 7)
    elsif @amount < 50 && @amount >= 30
      @level = Level.find_by(level_order: 6)
    elsif @amount < 30 && @amount >= 20
      @level = Level.find_by(level_order: 5)
    elsif @amount < 20 && @amount >=10
      @level = Level.find_by(level_order: 4)
    elsif @amount < 10 && @amount >= 5
      @level = Level.find_by(level_order: 3)
    elsif @amount < 5 && @amount >= 3
      @level = Level.find_by(level_order: 2)
    else @amount < 3 && @amount >= 1
      @level = Level.find_by(level_order: 1)
    end
    @level_name = @level.level_name
  end

  def new
    render :layout => nil
  end

  def create
    #binding.pry
    if params[:content] != ""
      parameter = URI.encode_www_form({output: 'json', keyword: params[:content]})
      uri = URI.parse("http://wikipedia.simpleapi.net/api?#{parameter}")
      response = Net::HTTP.get(uri)
      #@wiki_data = @response.body
      if response != "null"
        @body = JSON.parse(response)[0]["body"]
        #@wikidatum = Wikidatum.new(content: @body, post_content: params[:content])
        #@wikidatum.save
        @post = Post.new(content: params[:content], wiki_data: @body)
      else
        @post = Post.new(content: params[:content])
      end
      if @post.save
        flash[:notice] = "#{@post.content}を「とりあえずBOX」に登録しました"
        redirect_to("/")
      else
        #flash[:notice] = "#{@post.content}すでに登録されています"
        render("/")
      end
    else
      flash[:notice] = "単語を入力してください"
      redirect_to("/")
    end
  end

  def destroy
   @post = Post.find_by(id: params[:id])
   @post.destroy
   redirect_to("/")
  end

  def update
    #binding.pry
    @post = Post.find_by(id: params[:id])
    #@categories = Category.all
    if params[:content] != ""
      @post.content = params[:content]
    end
    if params[:category_name][:category_name] == ""
      @post.category_name = "その他"
    else
      @post.category_name = params[:category_name][:category_name]
      @category = Category.find_by(category_name: params[:category_name][:category_name])
      @post.category_color = @category.category_color
    end
    @post.definition = params[:definition]
    @post.registration_type = 1
    @post.save
    flash[:notice] = "学習済みリストに登録しました"
    redirect_to("/")
  end

  def categorize
    #binding.pry
    @post = Post.find_by(id: params[:id])
    @post.category_name = params[:category_name]
    @post.save
  end

end
