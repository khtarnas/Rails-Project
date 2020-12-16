class AddOfficialToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :official, :boolean, default: false
  end
end
