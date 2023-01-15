# frozen_string_literal: true

module Articles
  class ArticlesController < ApplicationController
    def index; end

    def fetch
      @articles = Articles::FetchArticlesOperation.call
    end

    def like
      @like = Articles::LikeArticleOperation.call(article_id: params[:id])

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_url }
      end
    end
  end
end
