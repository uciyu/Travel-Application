class CreateRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :records do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, foreign_key: true
      t.datetime :date  # dateカラムを追加
      t.string :image  # imageカラムを追加

      t.timestamps
    end
  end
end