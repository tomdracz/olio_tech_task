# frozen_string_literal: true

RSpec.describe 'Articles', type: :request do
  describe '#fetch' do
    it 'triggers the fetch articles operation' do
      allow(Articles::FetchArticlesOperation).to receive(:call).and_return([])
      get '/articles/articles/fetch'
      expect(Articles::FetchArticlesOperation).to have_received(:call)
    end
  end

  describe '#like' do
    it 'triggers the like article operation' do
      allow(Articles::LikeArticleOperation).to receive(:call)
        .with(article_id: '123')
        .and_return(instance_double(Articles::Like))
      patch '/articles/articles/123/like'
      expect(Articles::LikeArticleOperation).to have_received(:call).with(article_id: '123')
    end
  end
end
