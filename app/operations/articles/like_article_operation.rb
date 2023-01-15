# frozen_string_literal: true

module Articles
  class LikeArticleOperation
    def self.call(article_id:)
      new(article_id).call
    end

    def initialize(article_id)
      @article_id = article_id
    end

    def call
      add_or_update_like
    end

    private

    def add_or_update_like
      article_like = Like.create_or_find_by(article_id: @article_id)
      article_like.with_lock do
        article_like.like_count += 1
        article_like.save!
      end
      article_like
    end
  end
end
