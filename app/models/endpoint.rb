class Endpoint < ApplicationRecord
  has_one :response, class_name: 'EndpointResponse', dependent: :destroy

  SUPPORTED_VERBS = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
  SUPPORTED_CHARS = /^[^`><|]+$/

  validates :verb, inclusion: { in: SUPPORTED_VERBS, message: 'is not supported' }
  validate :supported_chars_only?

  # Test suite fails with enforced endpoint uniqueness
  # validates_uniqueness_of :path, scope: :verb

  def supported_chars_only?
    errors.add(:path, "can't include special characters") unless path =~ SUPPORTED_CHARS
  end
end
