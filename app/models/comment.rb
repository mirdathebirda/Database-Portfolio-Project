class Comment < ApplicationRecord
  #rails make table names automaatically plural - that's stupid we gun change dat
  self.table_name = "comment"

  def author_name
    #IN SQL GET AUTHOR NAME
        author = User.find_by_sql("SELECT * FROM user WHERE id = #{self.author};").first
        author.name
  end
end
