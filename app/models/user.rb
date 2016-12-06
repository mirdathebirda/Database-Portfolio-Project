class User < ApplicationRecord
  self.table_name = "user"

  has_secure_password

  def blogs
    Blog.find_by_sql "SELECT * FROM blog WHERE owner = #{self.id};"
  end

  def posts
    Post.find_by_sql "SELECT * FROM post WHERE user = #{self.id};"
  end

  def is_admin
    !Role.find_by_sql("SELECT * FROM user_role JOIN (role) ON (user_role.role=role.id) WHERE user = #{self.id} AND role.name='admin';").empty?
  end
end
