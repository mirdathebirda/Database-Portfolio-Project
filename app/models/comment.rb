class Comment < ApplicationRecord
  #rails make table names automaatically plural - that's stupid we gun change dat 
  self.table_name = "comment"
end
