class AddColumnsToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :header_id, :integer, :references => :entities
    add_column :entities, :multiplicity, :integer

    add_index :entities, :header_id
  end
end
