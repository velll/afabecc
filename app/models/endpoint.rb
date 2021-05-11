class Endpoint < ApplicationRecord
  has_one :response, class_name: 'EndpointResponse', dependent: :destroy
end
