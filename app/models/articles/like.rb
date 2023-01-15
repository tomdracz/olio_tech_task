# frozen_string_literal: true

module Articles
  class Like < ApplicationRecord
    def self.for_article(article_id:)
      find_by(article_id:)
    end
  end
end
