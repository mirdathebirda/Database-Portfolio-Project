class AddStarCountTrigger < ActiveRecord::Migration[5.0]
  def up
    execute "ALTER TABLE post ADD COLUMN star_count INT NOT NULL DEFAULT 0;"
    execute "CREATE TRIGGER star_count_update
              AFTER UPDATE ON star FOR EACH ROW
              BEGIN
                DECLARE stars INT;

                SELECT COUNT(*) INTO stars
                  FROM star
                  WHERE star.post = NEW.post
                  AND starred = true;

                UPDATE post
                SET post.star_count = stars
                WHERE NEW.post = post.id;
              END"
    execute "CREATE TRIGGER star_count_insert
              AFTER INSERT ON star FOR EACH ROW
              BEGIN
                DECLARE stars INT;

                SELECT COUNT(*) INTO stars
                  FROM star
                  WHERE star.post = NEW.post
                  AND starred = true;

                UPDATE post
                SET post.star_count = stars
                WHERE NEW.post = post.id;
              END"
    execute "UPDATE post SET star_count = (SELECT COUNT(*)
              FROM star
              WHERE star.post = post.id
              AND starred = true) WHERE post.id != -1;"
  end

  def down
    execute "DROP TRIGGER star_count_insert;"
    execute "DROP TRIGGER star_count_update;"
    execute "ALTER TABLE post DROP COLUMN star_count;"
  end
end
