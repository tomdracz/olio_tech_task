# frozen_string_literal: true

module Articles
  class Article
    attr_accessor :id, :title, :description, :town, :collection_notes, :photo, :user_name

    def self.build(raw_data:)
      new(
        id: raw_data['id'],
        title: raw_data['title'],
        description: raw_data['description'],
        town: raw_data['location']['town'],
        collection_notes: raw_data['collection_notes'],
        photo: raw_data['photos'][0]['files']['large'],
        user_name: raw_data['user']['first_name']
      )
    end

    def likes
      Like.for_article(article_id: id)&.like_count || 0
    end

    private

    def initialize(id:, title:, description:, town:, collection_notes:, photo:, user_name:)
      @id = id
      @title = title
      @description = description
      @town = town
      @collection_notes = collection_notes
      @photo = photo
      @user_name = user_name
    end
  end
end
