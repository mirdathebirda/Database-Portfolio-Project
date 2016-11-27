class AddBlogAndPosts < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TABLE blog (
        id INT PRIMARY KEY AUTO_INCREMENT,
        owner INT NOT NULL,
        title VARCHAR(52) NOT NULL,
        description TEXT NOT NULL,
        visible BOOLEAN DEFAULT TRUE,
        FOREIGN KEY(owner) REFERENCES user(id)
    );"

    execute "CREATE TABLE category (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(52) UNIQUE NOT NULL
    );"

    execute "CREATE TABLE post(
        id INT PRIMARY KEY AUTO_INCREMENT,
        author INT NOT NULL,
        blog INT NOT NULL,
        title VARCHAR(52) NOT NULL,
        body LONGTEXT NOT NULL,
        date DATETIME NOT NULL,
        FOREIGN KEY (author) REFERENCES user(id),
        FOREIGN KEY (blog) REFERENCES blog(id)
    );"

    execute "CREATE TABLE post_category(
        id INT PRIMARY KEY AUTO_INCREMENT,
        post INT,
        category INT,
        FOREIGN KEY(post) REFERENCES post(id),
        FOREIGN KEY(category) REFERENCES category(id),
        UNIQUE KEY post_category (post, category)
    );"
  end

  def down
    execute "DROP TABLE post_category;"
    execute "DROP TABLE post;"
    execute "DROP TABLE category;"
    execute "DROP TABLE blog;"
  end
end
