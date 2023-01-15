# frozen_string_literal: true

module Articles
  class ArticlesController < ApplicationController
    def index; end

    def fetch
      @articles = Articles::FetchArticlesOperation.call
    end
  end
end
