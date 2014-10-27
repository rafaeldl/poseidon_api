json.header do
  json.extract! @resource, *@resource.attribute_names
end

if @resource.class.name.eql?('Entity')
  json.set! :items do
    json.array! [:field] do |item|
      json.name item
      json.set! 'values' do
        json.array! @resource.many_field do |sub_item|
          json.extract! sub_item, *sub_item.attribute_names
        end
      end
    end
  end
else
  if defined? @resource.items
    json.items @resource.items do |item|
      json.name item.name
      json.set! 'values' do
        json.array! eval("item.many_#{item.name}") do |sub_item| # TODO: Ajustar para deixar generico para todas as entidades
          json.extract! sub_item, *sub_item.attribute_names
        end
      end
    end
  end
end
