class Post < ApplicationRecord
  self.table_name = "post"

  def comments
    Comment.find_by_sql "SELECT * FROM comment WHERE post = #{self.id};"
  end
end
