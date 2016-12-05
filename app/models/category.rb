class Category < ApplicationRecord
  self.table_name = "category"

  def postcategory
    PostCategory.find_by_sql "SELECT * FROM post_categories WHERE category = #{self.id};"
  end
end
