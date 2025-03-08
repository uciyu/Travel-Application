class RemoveImagesFromRecords < ActiveRecord::Migration[7.2]
  def change
    remove_column :records, :images, :text
  end
end
