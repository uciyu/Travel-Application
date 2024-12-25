class CreateRecordPrefectures < ActiveRecord::Migration[7.2]
  def change
    create_table :record_prefectures do |t|
      t.references :record, foreign_key: true
      t.references :prefecture, foreign_key: true

      t.timestamps
    end
    add_index :record_prefectures, [:record_id, :prefecture_id], unique: true
  end
end
