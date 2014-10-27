class RemovePrecisionFromFields < ActiveRecord::Migration
  def change
    remove_column :fields, :precision, :integer
    add_column :fields, :scale, :integer
  end
end
