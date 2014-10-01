json.resource do
  json.extract! @metadata, :name, :title, :description, :header_id, :multiplicity
end

json.fields @metadata.fields do |field|
  json.extract! field, :name, :title, :description, :kind, :mask, :size, :precision, :show_query, :show_index,
                :show_in, :virtual, :order, :options, :default, :foreign_filter
  json.foreign_name field.foreign.name if field.foreign
end