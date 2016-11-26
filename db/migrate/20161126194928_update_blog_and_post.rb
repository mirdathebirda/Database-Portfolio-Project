class UpdateBlogAndPost < ActiveRecord::Migration[5.0]
  def up
    execute "ALTER TABLE blog ADD COLUMN title VARCHAR(52);"
    execute "ALTER TABLE blog ADD COLUMN description TEXT;"

    execute "DROP TABLE postcategories;"
    execute "ALTER TABLE comment DROP FOREIGN KEY comment_ibfk_1;"
    execute "ALTER TABLE likes DROP FOREIGN KEY likes_ibfk_1;"
    execute "ALTER TABLE blog DROP FOREIGN KEY blog_ibfk_1;"
    execute "ALTER TABLE blog CHANGE COLUMN admin owner INT;"
    execute "ALTER TABLE blog ADD FOREIGN KEY (owner) REFERENCES user(id);"

    execute "ALTER TABLE post DROP FOREIGN KEY post_ibfk_2;"
    execute "ALTER TABLE blog DROP COLUMN blogID;"
    execute "ALTER TABLE blog ADD COLUMN id INT PRIMARY KEY AUTO_INCREMENT;"
    
    execute "ALTER TABLE post CHANGE COLUMN blogID blog INT;"
    execute "ALTER TABLE post ADD FOREIGN KEY (blog) REFERENCES blog(id);"
    execute "ALTER TABLE post DROP COLUMN postID;"
    execute "ALTER TABLE post ADD COLUMN id INT PRIMARY KEY AUTO_INCREMENT;"
    execute "ALTER TABLE comment ADD CONSTRAINT comment_ibfk_1 FOREIGN KEY (post) REFERENCES post(id);"
    execute "ALTER TABLE likes ADD CONSTRAINT likes_ibfk_1 FOREIGN KEY (post) REFERENCES post(id);"
  end

  def down
    execute "ALTER TABLE blog DROP COLUMN title;"
    execute "ALTER TABLE blog DROP COLUMN description;"

    execute "ALTER TABLE comment DROP FOREIGN KEY comment_ibfk_1;"
    execute "ALTER TABLE likes DROP FOREIGN KEY likes_ibfk_1;"
    execute "ALTER TABLE blog DROP FOREIGN KEY blog_ibfk_1;"
    execute "ALTER TABLE blog CHANGE COLUMN owner admin INT;"
    execute "ALTER TABLE blog ADD FOREIGN KEY (admin) REFERENCES user(id);"
    
    execute "ALTER TABLE post DROP FOREIGN KEY post_ibfk_2;"
    execute "ALTER TABLE blog DROP COLUMN id;"
    execute "ALTER TABLE blog ADD COLUMN blogID INT PRIMARY KEY AUTO_INCREMENT;"

    execute "ALTER TABLE post CHANGE COLUMN blog blogID INT;"
    execute "ALTER TABLE post ADD FOREIGN KEY (blogID) REFERENCES blog(blogID);"
    execute "ALTER TABLE post DROP COLUMN id;"
    execute "ALTER TABLE post ADD COLUMN postID INT PRIMARY KEY AUTO_INCREMENT;"
    execute "ALTER TABLE likes ADD CONSTRAINT likes_ibfk_1 FOREIGN KEY (post) REFERENCES post(postID);"
    execute "ALTER TABLE comment ADD CONSTRAINT comment_ibfk_1 FOREIGN KEY (post) REFERENCES post(postID);"
    execute "CREATE TABLE postcategories(id INT PRIMARY KEY AUTO_INCREMENT, post INT, category INT);"
  end
end
