# frozen_string_literal: true

RSpec.describe 'Articles', type: :request do
  describe '#fetch' do
    it 'triggers the fetch articles operation' do
      allow(Articles::FetchArticlesOperation).to receive(:call).and_return([])
      get '/articles/articles/fetch'
      expect(Articles::FetchArticlesOperation).to have_received(:call)
    end
  end
end
