class Blog < ApplicationRecord
  self.table_name = "blog"

  def posts
    Post.find_by_sql "SELECT * FROM post WHERE blog = #{self.id};"
  end
end
