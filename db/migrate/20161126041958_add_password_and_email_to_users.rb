class AddPasswordAndEmailToUsers < ActiveRecord::Migration[5.0]
  def up
    execute "ALTER TABLE user ADD COLUMN id INT PRIMARY KEY AUTO_INCREMENT;" 
    execute "ALTER TABLE user ADD COLUMN password_digest VARCHAR(100);" 
    execute "ALTER TABLE user ADD COLUMN email VARCHAR(52) UNIQUE;"

    execute "ALTER TABLE role MODIFY COLUMN name VARCHAR(52) UNIQUE;"
    execute "ALTER TABLE user DROP FOREIGN KEY user_ibfk_1;"
    execute "ALTER TABLE user DROP COLUMN role;"
    execute "ALTER TABLE user ADD COLUMN role INT;"
    execute "ALTER TABLE role DROP COLUMN roleID;"
    execute "ALTER TABLE role ADD COLUMN id INT PRIMARY KEY AUTO_INCREMENT;"
    execute "ALTER TABLE user ADD FOREIGN KEY (role) REFERENCES role(id);"
  end

  def down
    execute "ALTER TABLE user DROP FOREIGN KEY user_ibfk_1;"
    execute "ALTER TABLE role DROP COLUMN id;"
    execute "ALTER TABLE role ADD COLUMN roleID INT PRIMARY KEY AUTO_INCREMENT;"
    execute "ALTER TABLE user ADD FOREIGN KEY (role) REFERENCES role(roleID);"

    execute "ALTER TABLE user DROP COLUMN email;"
    execute "ALTER TABLE user DROP COLUMN password_digest;"
    execute "ALTER TABLE user DROP COLUMN id;"
  end
end