class Api::V1::UsersController < Api::V1::ApplicationController

  def create
    result = Catalog::Create.call(catalog_params)
  end

  private

  def catalog_params
    {
      catalog_file: params[:catalog_file]
    }
  end
end