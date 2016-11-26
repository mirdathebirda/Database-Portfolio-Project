class User < ApplicationRecord
  self.table_name = "user"

  has_secure_password
  
end
