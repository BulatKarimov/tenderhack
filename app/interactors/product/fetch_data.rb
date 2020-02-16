class Product::FetchData
  include Interactor

  def call
    context.file = File.open(tmp_path, 'rb').read

    response = HTTParty.post(url, headers: headers, body: body)

    unless response.success?
      context.fail!(error: error, status: :unprocessable)
    end

    predicts = response.parsed_response['msg']

    ids = []
    predicts.each { |predict| ids <<  predict.last }

    context.products = Product.where(id: ids)
  end

  private

  def url
    "http://vpn.roadar.ru:28137/api/v1/predict"
  end

  def headers
    { 'Content-Type': 'application/x-www-form-urlencoded' }
  end

  def body
    {
      'image': encoded_file
    }
  end

  def tmp_path
    context.image.tempfile.path
  end

  def encoded_file
    Base64.encode64(context.file)
  end

  def error
    {
        error: true,
        message: I18n.t('error.product.fetch_predict')
    }
  end
end