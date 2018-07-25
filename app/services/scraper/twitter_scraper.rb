# frozen_string_literal: true

require_relative '../browser/simple_browser'

TIMELINE_SELECTOR = '#timeline'
TWEET_SELECTOR = '.tweet'
TWEET_TEXT_SELECTOR = '.tweet-text'
TWEET_AUTHOR_SELECTOR = '.account-group'
TWEET_AUTHOR_FULL_NAME_SELECTOR = '.fullname'
TWEET_AUTHOR_USERNAME_SELECTOR = '.username'
TWEET_CREATED_AT_SELECTOR = '.tweet-timestamp ._timestamp'
TWEET_CREATED_AT_ATTRIBUTE = 'data-time-ms'

module Scraper
  # Simple scraper that analyzes twitter's search page to extract tweets for a
  # given term
  class TwitterScraper
    attr_reader :term

    def initialize(term, browser = Browser::SimpleBrowser.new)
      raise ArgumentError, 'invalid term' unless term

      @term = term
      @browser = browser
    end

    def content
      find_tweets.collect { |t| parse_tweet(t) }
    end

    private

    def search_page
      @search_page ||= Nokogiri::HTML(twitter_search_page_html(@term))
    end

    def find_tweets
      search_page.css(TWEET_SELECTOR)
    end

    def parse_tweet(tweet)
      {
        content: find_text(tweet),
        author: find_author(tweet),
        created_at: find_created_at(tweet)
      }
    end

    def find_text(tweet)
      tweet.css(TWEET_TEXT_SELECTOR).text
    end

    def find_author(tweet)
      user_info = tweet.css(TWEET_AUTHOR_SELECTOR)
      {
        full_name: user_info.css(TWEET_AUTHOR_FULL_NAME_SELECTOR).text,
        username: user_info.css(TWEET_AUTHOR_USERNAME_SELECTOR).text
      }
    end

    def find_created_at(tweet)
      tweet.css(TWEET_CREATED_AT_SELECTOR).attribute(TWEET_CREATED_AT_ATTRIBUTE).value
    end

    def twitter_search_page_html(_term)
      @browser.open_url(twitter_search_url(@term))
      @browser.html
    end

    def twitter_search_url(term = '')
      # We will use the search page to find tweets containing the term we want to find
      "https://twitter.com/search?q=#{CGI.escape(term)}"
    end
  end
end
