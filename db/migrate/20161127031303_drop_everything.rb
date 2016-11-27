class DropEverything < ActiveRecord::Migration[5.0]
  def up
    # There were issues with the previous schema

    drop_table :likes
    drop_table :comment
    drop_table :post
    drop_table :blog
    drop_table :user
    drop_table :category
    drop_table :role
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
