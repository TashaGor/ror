class AddCommentsToPost < ActiveRecord::Migration
  def change
    add_belongs_to :comments, :post
  end
end
