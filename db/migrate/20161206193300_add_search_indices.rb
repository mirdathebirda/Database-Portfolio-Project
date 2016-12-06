class AddSearchIndices < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE INDEX name ON user (name);"
    execute "CREATE INDEX title ON post (title);"
    execute "CREATE INDEX title ON blog (title);"
  end

  def down
    execute "DROP INDEX title ON post;"
    execute "DROP INDEX title ON blog;"
    execute "DROP INDEX name ON user;"
  end
end
