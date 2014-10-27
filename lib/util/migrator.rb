class Migrator < ActiveRecord::Migration

  def self.create_entity(entity)

    create_table entity.name.downcase.to_sym do |t|

      # Cria chave estrangeira
      if entity.header
        t.references entity.header.name
      end

      # cria demais campos da tabela
      entity.many_field.each do |f|
        unless f.visibility.eql?('V')
          field_name = f.name.downcase.to_sym
          options = field_options(f)
          eval("t.#{f.kind.to_s} field_name, options")
        end
      end
    end
    puts "create_entity #{entity.name}"
  end

  private

  def self.field_options(field)
    options = {}
    if field.size
      if field.kind.eql?('decimal')
        options[:precision] = field.size
        options[:scale] = field.scale
      else
        options[:limit] = field.size
      end
    end
    if field.foreign_entity
      foreign = Entity.find(field.foreign_entity)
      options[:references] = foreign.name.to_sym
    end
    options
  end

end