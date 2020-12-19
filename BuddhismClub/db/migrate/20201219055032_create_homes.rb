class CreateHomes < ActiveRecord::Migration[5.2]
  def change
    create_table :homes do |t|
      t.string :city, default: "Philadelphia"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
