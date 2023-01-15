# frozen_string_literal: true

class CreateArticlesLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :articles_likes do |t|
      t.integer :article_id, null: false
      t.integer :like_count, default: 0, null: false

      t.timestamps
    end

    add_index :articles_likes, :article_id, unique: true
  end
end
