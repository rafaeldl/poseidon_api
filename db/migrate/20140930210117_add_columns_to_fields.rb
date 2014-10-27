class AddColumnsToFields < ActiveRecord::Migration
  def change
    add_column :fields, :size, :integer
    add_column :fields, :precision, :integer
    add_column :fields, :show_query, :boolean
    add_column :fields, :show_index, :boolean
    add_column :fields, :show_in, :string
    add_column :fields, :scale, :string, limit: 1
    add_column :fields, :editable, :boolean
    add_column :fields, :order, :integer
    add_column :fields, :required, :boolean
    add_column :fields, :options, :string
    add_column :fields, :default, :string
    add_column :fields, :foreign_entity, :integer, :references => :entities
    add_column :fields, :foreign_filter, :string

    add_index :fields, :foreign_entity
  end
end
