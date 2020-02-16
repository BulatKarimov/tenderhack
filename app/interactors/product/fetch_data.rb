class Product::FetchData
  include Interactor

  def call
    context.file = File.open(tmp_path, 'rb').read

    response = HTTParty.post(url, headers: headers, body: body)

    unless response.success?
      context.fail!(error: error, status: :unprocessable)
    end

    similiar = response.parsed_response['msg']
    result = response.parsed_response['msg_filtered']
    similiar_ids = []
    result_ids = []

    similiar.each { |s| similiar_ids << s.last }
    result.each { |r| result_ids << r.last }

    context.semiliar_products = Product.where(id: similiar_ids)
    context.result_products = Product.where(id: result_ids)
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
    context.image.path
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