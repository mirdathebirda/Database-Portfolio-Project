class CategoriesController < ApplicationController

  def create
    cols = post_category_params.keys.join(", ")
    vals = post_category_params.values.map{|val| %Q(#{PostCategory.sanitize(val)})}.join(", ")
    Category.connection.execute("INSERT INTO category(#{cols}) SELECT * FROM (SELECT #{vals}) AS tmp WHERE NOT EXISTS (
    SELECT name FROM category WHERE name = #{vals});")
    category = Category.find_by_sql("SELECT * FROM category WHERE name = #{vals};").first
    PostCategory.connection.execute("INSERT INTO post_category(post, category) VALUES (#{params[:post_id]}, #{category.id})")
    redirect_to :back
  end

  def destroy
    PostCategory.connection.execute("DELETE FROM post_category WHERE id = #{params[:id]}")
    redirect_to :back
  end

private

  def post_category_params
    params.require(:category).permit(:name)
  end
end
