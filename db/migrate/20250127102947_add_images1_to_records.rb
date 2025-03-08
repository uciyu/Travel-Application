class AddImagesToRecords < ActiveRecord::Migration[7.2]
  def change
    add_column :records, :images, :text
  end
end
