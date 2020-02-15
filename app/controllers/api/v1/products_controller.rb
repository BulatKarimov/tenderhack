class Api::V1::ProductsController < Api::V1::ApplicationController

  def search
    result = Offer::FindByImage.call(offer_params)

    if result.success?
      render json: result.offers, each_serializer: OffersSerializer, status: :ok
    else
      render json: result.error, status: result.status
    end
  end

  private

  def offer_params
    {
      image: params[:image]
    }
  end
end
