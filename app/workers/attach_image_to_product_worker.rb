require 'find'

class AttachImageToProductWorker
  include Sidekiq::Worker

  def perform
    products = Product.all

    puts "Product count: #{products.size}"

    image_paths = []
    Find.find(base_path) do |path|
      image_paths << path if path =~ /.*\.jpg$/

      puts "Image paths count: #{image_paths.size}"
    end

    products.each do |product|
      image_path = image_paths.select { |path| path if path.include?(product.id.to_s) }
      next unless image_path.present?

      product.image.attach(io: File.open(image_path), filename: "#{product.id}.jpg")
    end
  end

  private

  def base_path
    '/Users/bulatkarimov/Downloads/83522'
  end
end