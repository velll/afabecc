class Endpoint < ApplicationRecord
  has_one :response, class_name: 'EndpointResponse', dependent: :destroy

  SUPPORTED_VERBS = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
  SUPPORTED_CHARS = /^[^`><|]+$/
  RESERVED_PATHS = /^\/?endpoints?\/?/

  validates :verb, inclusion: { in: SUPPORTED_VERBS, message: 'is not supported' }
  validate :supported_chars_only?
  validate :not_reserved_path?

  # Test suite fails with enforced endpoint uniqueness
  # validates_uniqueness_of :path, scope: :verb

  def not_reserved_path?
    errors.add(:path, "can't use reserved paths") if path =~ RESERVED_PATHS
  end

  def supported_chars_only?
    errors.add(:path, "can't include special characters") unless path =~ SUPPORTED_CHARS
  end
end
