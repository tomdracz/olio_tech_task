# frozen_string_literal: true

RSpec.describe Articles::FetchArticlesOperation do
  let(:api_response) { instance_double(HTTParty::Response, parsed_response: api_response_body, success?: success) }
  let(:api_response_body) { JSON.parse(file_fixture('articles/all_articles.json').read) }

  before do
    allow(HTTParty).to receive(:get).and_return(api_response)
  end

  describe 'fetching articles' do
    let(:operation_result) { described_class.call }

    context 'when API response is successful' do
      let(:success) { true }

      it 'returns array of products' do
        expect(operation_result).to include(a_kind_of(Articles::Article)).exactly(25).times
      end
    end

    context 'when API response failed' do
      let(:success) { false }

      it 'returns empty array' do
        expect(operation_result).to eq([])
      end
    end
  end
end
