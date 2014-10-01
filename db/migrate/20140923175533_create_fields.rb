class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :company, index: true
      t.references :entity, index: true
      t.string :name
      t.string :title
      t.string :description
      t.string :kind
      t.string :mask

      t.timestamps
    end
  end
end
