module UrlUtils
  extend self

  # Remove leading and trailing slashes
  def normalize_path(path)
    path.match(/^\/*(.+?)\/*$/).captures.first
  end
end
