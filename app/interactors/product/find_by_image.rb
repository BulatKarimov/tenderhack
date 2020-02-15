class Offer::FindByImage
  include Interactor::Organizer

  # TODO some shit after FetchData from python neural network
  organize Offer::ValidateParams, Offer::FetchData
end
