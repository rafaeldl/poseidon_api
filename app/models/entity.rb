class Entity < ActiveRecord::Base
  belongs_to :company
  has_many :fields

  accepts_nested_attributes_for :fields
end
