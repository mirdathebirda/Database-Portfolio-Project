class Post < ApplicationRecord
  self.table_name = "post"


  def categories
     Category.find_by_sql("SELECT * FROM category INNER JOIN post_category ON category.id = post_category.category
     WHERE category.id = post_category.category AND post_category.post = #{self.id};")
  end



  def comments
    Comment.find_by_sql "SELECT * FROM comment WHERE post = #{self.id};"
  end
end
