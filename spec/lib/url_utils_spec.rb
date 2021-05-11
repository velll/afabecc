require 'rails_helper'

RSpec.describe UrlUtils do
  describe '#normalize_path' do
    it 'leaves the path as is' do
      expect(UrlUtils.normalize_path('hello')).to eq('hello')
      expect(UrlUtils.normalize_path('hello/there')).to eq('hello/there')
    end

    it 'removes leading slash(es)' do
      expect(UrlUtils.normalize_path('/hello')).to eq('hello')
      expect(UrlUtils.normalize_path('//hello')).to eq('hello')
    end

    it 'removes trailing slash(es)' do
      expect(UrlUtils.normalize_path('hello/')).to eq('hello')
      expect(UrlUtils.normalize_path('hello//')).to eq('hello')
    end

    it 'removes both leading and trailing slash(es)' do
      expect(UrlUtils.normalize_path('/hello/')).to eq('hello')
      expect(UrlUtils.normalize_path('///hello/////')).to eq('hello')
    end
  end
end
