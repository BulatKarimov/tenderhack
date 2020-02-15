class Api::V1::ProductsController < Api::V1::ApplicationController

  def index
    products = Product.search(params[:query])

    render json: products, #each_serializer: ProductListSerializer,
           status: :ok
  end

  def show
    product = Product.find_by(id: params[:product_id])

    if product.present?
      render json: product, #serializer: ProductSerializer,
             status: :ok
    else
      render json: { error: true, message: 'error.product.not_found' },
             status: :not_found
    end
  end

  def search
    result = Product::FindByImage.call(product_params)

    if result.success?
      render json: result.products, each_serializer: ProductsSerializer, status: :ok
    else
      render json: result.error, status: result.status
    end
  end

  private

  def product_params
    {
      image: params[:image]
    }
  end
end
