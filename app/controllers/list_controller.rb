
class ListController < ApplicationController


  def words
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

    if @level
      @level_name = @level.level_name
    end

    @words = Post.where(registration_type: 1).order(updated_at: :desc)
    @categories = Category.where.not(category_name: nil).order(updated_at: :asc)
  end

  def category_destroy
    @category = Category.find_by(id: params[:id])
    if @category.category_color == nil
      @category.destroy
    else
      @category.category_name = ""
      @category.save
    end
    redirect_to("/list/words")
  end

  def create
    @category = Category.find_by(category_name: "")
    if @category
      @category.category_name = params[:category_name]
    else
      @category = Category.new(category_name: params[:category_name])
    end
      @category.save
      redirect_to("/list/words")
  end

  def destroy
    @word = Post.find_by(id: params[:id])
    @word.destroy
    redirect_to("/list/words")
  end

  def search_result
    @categories = Category.where("category_name not ?", "")
    @search_results = Post.search(params[:content], params[:category_name][:category_name])
    if params[:category_name][:category_name] == ""
      @category_name = "その他"
    else
      @category_name = params[:category_name][:category_name]
      @category = Category.find_by(category_name: params[:category_name][:category_name])
      @category_color = @category.category_color
    end
  end
end
