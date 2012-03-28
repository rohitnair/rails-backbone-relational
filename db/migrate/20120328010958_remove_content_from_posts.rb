class RemoveContentFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :content
  end

  def down
    add_column :posts, :content
  end
end
