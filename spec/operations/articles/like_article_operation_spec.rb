# frozen_string_literal: true

RSpec.describe Articles::LikeArticleOperation do
  let(:operation_result) { described_class.call(article_id:) }

  describe 'adding likes' do
    context 'when no likes yet added for the article' do
      it 'creates new like record for the article' do
        expect { described_class.call(article_id: 123) }.to change(Articles::Like, :count).by(1)
      end
    end

    context 'with likes already existing for the article' do
      let!(:article_like) { Articles::Like.create(article_id: 456, like_count: 5) }

      it 'does not create new record for the article like' do
        expect { described_class.call(article_id: 456) }.not_to change(Articles::Like, :count)
      end

      it 'updates the like count for article by 1' do
        described_class.call(article_id: 456)
        expect(article_like.reload.like_count).to eq(6)
      end
    end
  end
end
