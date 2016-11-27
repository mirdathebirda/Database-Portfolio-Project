class AddUsersAndRoles < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TABLE role (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(52) UNIQUE
    );"

    execute "CREATE TABLE user (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(52) NOT NULL,
        email VARCHAR(52) UNIQUE,
        password_digest TEXT NOT NULL
    );"

    execute "CREATE TABLE user_role (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user INT,
        role INT,
        FOREIGN KEY(user) REFERENCES user(id),
        FOREIGN KEY(role) REFERENCES role(id),
        UNIQUE KEY user_role (user, role)
    );"
  end

  def down
    execute "DROP TABLE user_role;"
    execute "DROP TABLE user;"
    execute "DROP TABLE role;"
  end
end
