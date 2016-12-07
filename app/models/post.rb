class Post < ApplicationRecord
  self.table_name = "post"

  def self.search(search, blog, page_size, page)
    # searching categories
    category_post_ids = PostCategory.find_by_sql("SELECT * FROM post_category INNER JOIN category ON post_category.category = category.id
      WHERE category.name LIKE '%#{search}%' ORDER BY post_category.post DESC;").map(&:post).uniq
    if category_post_ids.empty?
      category_posts = []
    else
      category_posts = Post.find_by_sql("SELECT * FROM post WHERE id IN (#{category_post_ids.to_s[1..-2]});")
    end

    # search authors, titles, text
    posts = Post.find_by_sql("SELECT * FROM post INNER JOIN user ON post.author = user.id WHERE blog = #{blog} AND (title LIKE '%#{search}%' OR body LIKE '%#{search}%' OR user.name LIKE '%#{search}%');")
    puts "#{category_posts.map(&:id)} blahh #{posts.map(&:id)}"
    results = (category_posts + posts).uniq
    results = results[((page - 1) * page_size)..-1][0..page_size]
  end

  def stringCategory
    category = Category.find_by_sql("SELECT * FROM category INNER JOIN post_category ON category.id = post_category.category
    WHERE post_category.post = #{self.id};")
    category.pluck(:name).join(", ")

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

  def author_name
        author = User.find_by_sql("SELECT * FROM user WHERE id = #{self.author};").first
        author.name
  end

  def format_date
    single_post =  User.find_by_sql("SELECT * FROM post WHERE id = #{self.id};").first
    require 'date'
    d = Date.parse(single_post.date.to_s)
    d.strftime("%v")
  end
end
