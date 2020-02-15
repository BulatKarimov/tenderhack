class DatabaseTransferWorker
  include Sidekiq::Worker

  def perform
    file = Roo::Spreadsheet.open("#{Rails.root}/ste.xlsx")

    puts('Started')
    (2..65535).each do |k|
      file_product = file.sheet(0).row(k)
      puts k
      product = Product.new()
      product.id = id(file_product)
      product.name = name(file_product)
      product.manufacturer = manufacturer(file_product)
      product.manufacturer_country = manufacturer_country(file_product)
      product.product_type = type(file_product)
      product.length = length(file_product)
      product.width = width(file_product)
      product.height = height(file_product)
      product.material = material(file_product)
      product.diameter = diameter(file_product)
      product.color = color(file_product)
      product.weight = weight(file_product)
      product.volume = volume(file_product)
      product.amount = amount(file_product)

      product.save
    end
  end

  private

  def serialized_data(data, number: false)
    data = data == 'NULL' ? nil : data

    return data.to_f if number

    data
  end

  def id(data)
    data[0].to_i
  end

  def name(data)
    serialized_data(data[1])
  end

  def manufacturer(data)
    serialized_data(data[2])
  end

  def manufacturer_country(data)
    serialized_data(data[3])
  end

  def type(data)
    serialized_data(data[4])
  end

  def length(data, number: true)
    serialized_data(data[6])
  end

  def width(data, number: true)
    serialized_data(data[7])
  end

  def height(data, number: true)
    serialized_data(data[8])
  end

  def material(data)
    serialized_data(data[9])
  end

  def diameter(data, number: true)
    serialized_data(data[10])
  end

  def color(data)
    serialized_data(data[12])
  end

  def weight(data, number: true)
    serialized_data(data[13])
  end

  def volume(data, number: true)
    serialized_data(data[14])
  end

  def amount(data, number: true)
    serialized_data(data[16])
  end
end