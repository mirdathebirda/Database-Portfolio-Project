class AddStarsAndComments < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TABLE comment (
      id INT PRIMARY KEY AUTO_INCREMENT,
        author INT NOT NULL,
        post INT NOT NULL,
      date DATETIME NOT NULL,
      visible BOOLEAN DEFAULT TRUE,
        FOREIGN KEY(author) REFERENCES user(id),
      FOREIGN KEY(post) REFERENCES post(id)
    );"

    execute "CREATE TABLE star (
      id INT PRIMARY KEY AUTO_INCREMENT,
      user INT NOT NULL,
        post INT NOT NULL,
      starred BOOLEAN DEFAULT TRUE,
        FOREIGN KEY(user) REFERENCES user(id),
        FOREIGN KEY(post) REFERENCES post(id),
      UNIQUE KEY user_star (user, post)
    );"
  end

  def down
    execute "DROP TABLE star;"
    execute "DROP TABLE comment;"
  end
end
