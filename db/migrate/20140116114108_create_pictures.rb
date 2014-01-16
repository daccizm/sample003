class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.string :description
      t.integer :num_of_images

      t.timestamps
    end
  end
end
