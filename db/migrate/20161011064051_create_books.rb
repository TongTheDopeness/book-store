class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.text :desc

      t.timestamps null: false
    end
  end
end
