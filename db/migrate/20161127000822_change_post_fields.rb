class ChangePostFields < ActiveRecord::Migration[5.0]
  def up
    execute "ALTER TABLE post CHANGE COLUMN comment body LONGTEXT NOT NULL;"
    execute "ALTER TABLE post DROP COLUMN isLiked;"
    execute "ALTER TABLE post DROP FOREIGN KEY post_ibfk_1;"
    execute "ALTER TABLE post DROP COLUMN tag;"
  end

  def down
    execute "ALTER TABLE post ADD COLUMN tag VARCHAR(52);"
    execute "ALTER TABLE post ADD CONSTRAINT post_ibfk_1 FOREIGN KEY (tag) REFERENCES category(type);"
    execute "ALTER TABLE post ADD COLUMN isLiked BOOLEAN;"
    execute "ALTER TABLE post CHANGE COLUMN body comment LONGTEXT NOT NULL;"
  end
end
