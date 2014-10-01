class Field < ActiveRecord::Base
  belongs_to :company
  belongs_to :entity
  belongs_to :foreign, :class_name => Entity, :foreign_key => :foreign_entity
end
