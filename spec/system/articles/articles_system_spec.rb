# frozen_string_literal: true

RSpec.describe 'viewing articles', type: :system do
  before do
    allow(Articles::FetchArticlesOperation).to receive(:call).and_return(articles_response)
  end

  describe 'viewing articles' do
    before do
      visit articles_articles_path
    end

    context 'when no articles listed' do
      let(:articles_response) { [] }

      it 'displays a message to the user advising that no articles are listed' do
        expect(page).to have_content('No articles currently listed')
      end
    end

    context 'when articles available' do
      let(:articles_fixture) { JSON.parse(file_fixture('articles/three_articles.json').read) }
      let(:articles_response) { articles_fixture.map { |article| Articles::Article.build(raw_data: article) } }

      it 'renders all available articles' do
        expect(page).to have_selector('.article', count: 3)
      end

      context 'for individual article' do
        it 'displays article title' do
          within('#article-3899651') do
            expect(page).to have_content('Waterproof jacket with integrated hood')
          end
        end

        it 'displays article description' do
          within('#article-3899651') do
            expect(page).to have_content('Size 42R, not used. #back2school')
          end
        end

        it 'displays article image' do
          within('#article-3899651') do
            expect(page).to have_css("img[src='https://cdn.olioex.com/uploads/photo/file/PEjDytnWyyHcl-3wjV9ZAg/large_image.jpg']")
          end
        end

        it 'displays article collection notes' do
          within('#article-3899651') do
            expect(page).to have_content('Any time')
          end
        end

        it 'displays article user and location' do
          within('#article-3899651') do
            expect(page).to have_content('Lloyd, Ystalyfera')
          end
        end
      end
    end
  end
end
