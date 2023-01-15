# frozen_string_literal: true

module Articles
  class FetchArticlesOperation
    BASE_URL = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'

    def self.call(url: BASE_URL)
      new(url:).call
    end

    def initialize(url:)
      @url = url
    end

    def call
      response = HTTParty.get(@url)
      if response.success?
        build_products(parsed_response: response.parsed_response)
      else
        []
      end
    end

    private

    def build_products(parsed_response:)
      parsed_response.map { |raw_product| Articles::Article.build(raw_data: raw_product) }
    end
  end
end
