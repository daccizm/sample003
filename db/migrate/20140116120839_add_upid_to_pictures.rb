class AddUpidToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :upid, :string
  end
end
