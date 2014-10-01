class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.references :company, index: true
      t.string :name
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
