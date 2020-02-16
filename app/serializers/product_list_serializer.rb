class ProductListSerializer < ActiveModel::Serializer
  attributes :id, :name, :manufacturer, :manufacturer_country,
             :product_type, :length, :width, :material, :color, :weight,
             :volume, :amount

end
