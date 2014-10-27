json.resource do
  json.extract! @metadata, :id, :name, :title, :description, :header_id, :multiplicity
end

json.fields @metadata.many_field do |field|
  json.extract! field, :name, :title, :description, :kind, :mask, :size, :scale, :show_query, :show_index,
                :show_in, :visibility, :order, :options, :default, :foreign_entity, :foreign_filter, :required
  json.foreign_name field.foreign.name if field.foreign
end

json.items @metadata.items.includes(:many_field) do |item|
  json.resource do
    json.extract! item, :name, :title, :description, :header_id, :multiplicity
  end

  json.fields item.many_field do |field|
    json.extract! field, :name, :title, :description, :kind, :mask, :size, :scale, :show_query, :show_index,
                  :show_in, :visibility, :order, :options, :default, :foreign_entity, :foreign_filter, :required
    json.foreign_name field.foreign.name if field.foreign
  end
end