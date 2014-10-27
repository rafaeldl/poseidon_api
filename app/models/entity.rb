require 'util/migrator'

class Entity < ActiveRecord::Base
  belongs_to :company
  has_many :many_field, :class_name => Field, :dependent => :delete_all
  has_many :items, :class_name => Entity, :foreign_key => :header_id
  belongs_to :header, :class_name => Entity, :foreign_key => :header_id

  accepts_nested_attributes_for :many_field

  after_create :create_table

  def foreign_values
  # TODO: Metodo para retornar os valores das chaves estrangeiras
  end

  private

  def create_table
    Migrator.create_entity(self)
  end
end
