# README

## Requirements

The project requires Ruby 3.1.3 installed, Chrome browser is required for running the system tests

## Installation

In the repo root run the following to install the dependencies and initialise the database:

```bash
  bundle install
```

```bash
  bundle exec rails db:create
```

## Running application

```bash
  ./bin/dev
```

The app can be then accessed in the browser at http://localhost:3000

## Running tests

```bash
  bundle exec rspec
```

## App flow

When accessing the root page, Rails app will load [Articles::ArticlesController](app/controllers/articles/articles_controller.rb) behind the scenes.

On initial load, the app will try and load the articles from the API endpoint using `#fetch` action in the same controller above, so the initial load is not blocked by waiting for the API response. If API response succeeds, the articles will be displayed, if it fails for any reason, user will see a message advising there are no articles currently available to be displayed.

Fetching articles from the API is implemented by [Articles::FetchArticlesOperation](app/operations/articles/fetch_articles_operation.rb). This operation fetches the response from the API and attempts to build an array of article instances. If nothing is available from the API, empty array is returned.

Article model declaration can be found at [Articles::Article](app/models/articles/article.rb). There, the JSON API from the response is used to create article model instances. You can use this file to add any additional variables and methods for the article. Currently, only subset of the data available in the API is made available through the app interface. The original object is available as `raw_data` variable in the `self.build` method on the Article so that's the first point of call for any new data to be added.

If you like to have a look at frontend display of the articles, refer to the [article view partial](app/views/articles/articles/_article.html.erb). This is loaded and rendered for each of the articles build, any styling and display changes can be implemented there. Currently, a fairly low-fi display has been implemented driven by TailwindCSS.

Each article can have "likes" associated with it. There are few caveats to note here:
- API response includes "likes" information under `reactions` key in JSON. This is unused, the likes displayed and saved by the app are completely independent
- There is no user identifier available so effectively, anyone can click and add likes ad infinitum

Each click on the "Add Like!" button triggers [Articles::LikeArticleOperation](app/operations/articles/like_article_operation.rb). For each of the article, only one row will ever exist in the database, with the current likes counts stored in the `like_count` column. If the article had no likes previously added, a new row is added to the database, otherwise, if likes are already present, their count is updated by 1 on each like button click. Row locking is used to prevent race conditions and incorrect updates to the counts.

Just as with the initial article load, each like interaction is powered by Rails Turbo capabilities. This allows the interface to update seamlessly without full page reloads. Once the like button is clicked, a `#like` action is triggered on the [Articles::ArticlesController](app/controllers/articles/articles_controller.rb), `LikeArticleOperation` is called and with the result of that, a [turbo stream file](app/views/articles/articles/like.turbo_stream.erb) is rendered. This through the magic of JS and Turbo (!), renders new version of the partial view that displays article likes and replaces the old version. Magic!
