class Blog < ApplicationRecord
  self.table_name = "blog"

  def author_name
        author = User.find_by_sql("SELECT * FROM user WHERE id = #{self.owner};").first
        author.name
  end

  def posts
    Post.find_by_sql "SELECT * FROM post WHERE blog = #{self.id};"
  end
end
