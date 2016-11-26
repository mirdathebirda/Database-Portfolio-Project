class User < ApplicationRecord
  self.table_name = "user"

  has_secure_password

  def blogs
    Blog.find_by_sql "SELECT * FROM blog WHERE owner = #{self.id};"
  end

  def posts
    Post.find_by_sql "SELECT * FROM post WHERE user = #{self.id};"
  end
end
