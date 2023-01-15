# frozen_string_literal: true

RSpec.describe Articles::Article do
  let(:fixture) { file_fixture('articles/article.json') }
  let(:raw_data) { JSON.parse(fixture.read) }
  let(:article) { described_class.build(raw_data:) }

  describe '#build' do
    it 'builds instance of an article with the id from the raw data passed' do
      expect(article.id).to eq(3_899_631)
    end

    it 'builds instance of an article with the title from the raw data passed' do
      expect(article.title).to eq('Ambipur air freshener plugin')
    end

    it 'builds instance of an article with the description from the raw data passed' do
      expect(article.description).to eq('Device only but refills are available most places')
    end

    it 'builds instance of an article with the town from the raw data passed' do
      expect(article.town).to eq('Ystalyfera')
    end

    it 'builds instance of an article with the collection notes from the raw data passed' do
      expect(article.collection_notes).to eq('Any time!')
    end

    it 'builds instance of an article with the photo from the raw data passed' do
      expect(article.photo).to eq('https://cdn.olioex.com/uploads/photo/file/00gRGrBRDFYrR2j-9SJVYg/large_image.jpg')
    end

    it 'builds instance of an article with the user name from the raw data passed' do
      expect(article.user_name).to eq('Lloyd')
    end
  end

  describe '#likes' do
    context 'when any likes already added' do
      before do
        2.times do
          Articles::LikeArticleOperation.call(article_id: article.id)
        end
      end

      it 'returns like count for a given article' do
        expect(article.likes).to eq(2)
      end
    end

    context 'with no likes added yet' do
      it 'returns like count of 0' do
        expect(article.likes).to eq(0)
      end
    end
  end
end
