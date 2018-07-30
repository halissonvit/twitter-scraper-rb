# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    scraper = Scraper::TwitterScraper.new('#MLHLocalhost')
    @results = scraper.content
  end
end
