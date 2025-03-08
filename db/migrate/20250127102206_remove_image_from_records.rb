class RemoveImageFromRecords < ActiveRecord::Migration[7.2]
  def change
    remove_column :records, :image, :string
  end
end
