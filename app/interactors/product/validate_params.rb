class Product::ValidateParams
  include Interactor

  before do
    unless context.image.present?
      context.fail!(error: error('error.product.image_required'),
                    status: :unprocessable_entity)
    end
  end



  def call
    unless content_type.include?('image')
      context.fail!(error: error('error.product.unavailable_content_type?'),
                    status: :unprocessable_entity)
    end
  end

  private

  def error(message)
    {
        error: true,
        message: I18n.t(message)
    }
  end
end