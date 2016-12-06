class Post < ApplicationRecord
  self.table_name = "post"

  def self.search(search, blog, page_size, page)
    Post.find_by_sql("SELECT * FROM post INNER JOIN user ON post.author = user.id WHERE blog = #{blog} AND (title LIKE '%#{search}%' OR body LIKE '%#{search}%' OR user.name LIKE '%#{search}%') LIMIT #{(page - 1) * page_size}, #{page_size + 1};")

  end

  def categories
     Category.find_by_sql("SELECT * FROM category INNER JOIN post_category ON category.id = post_category.category
     WHERE category.id = post_category.category AND post_category.post = #{self.id};")
  end

  def comments
    Comment.find_by_sql "SELECT * FROM comment WHERE post = #{self.id};"
  end

  def starred_by(user)
    !Star.find_by_sql("SELECT * FROM star WHERE post = #{self.id} AND user = #{user.id} AND starred = true;").empty?
  end
end
