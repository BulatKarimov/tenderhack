class Product::FindByImage
  include Interactor::Organizer

  # TODO some shit after FetchData from python neural network
  organize Product::ValidateParams, Product::FetchData
end
