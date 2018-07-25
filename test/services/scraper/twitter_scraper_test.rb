# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'
require_relative '../../../app/services/scraper/twitter_scraper'

TWITTER_RESULTS_PAGE_EXAMPLE_FILE = "#{__dir__}/twitter_results_page_example.html"

class TwitterScraperTest < ActiveSupport::TestCase
  def setup
    browser = mock_browser(mock_twitter_search_page_html)

    @term = '#MLHLocalhost'
    @scraper = Scraper::TwitterScraper.new(@term, browser)
  end

  def mock_browser(content)
    browser = Minitest::Mock.new
    browser.expect :open_url, nil, [String]
    browser.expect :html, content
    browser
  end

  def mock_twitter_search_page_html
    @mock_twitter_search_page_html ||= File.read(TWITTER_RESULTS_PAGE_EXAMPLE_FILE)
  end

  def assert_result_with_content_is_present(_expected_value, &block)
    assert @scraper.content.find(&block)
  end

  test 'can be instantiated' do
    assert @scraper
  end

  test 'expects a valid term to search for' do
    assert_raises ArgumentError do
      Scraper::TwitterScraper.new(nil)
    end
  end

  test 'expects a term to search for' do
    assert_equal @term, @scraper.term
  end

  test 'returns results for the searched term' do
    results = @scraper.content

    assert_not results.empty?
  end

  test "results contain tweet's content" do
    expected_content = 'We had yet another workshop at Queens College Tech Incubator this Saturday morning'

    assert_result_with_content_is_present(expected_content) do |result|
      result[:content].include?(expected_content)
    end
  end

  test "results contain tweet's author full name" do
    expected_name = 'Sumaiya'
    assert_result_with_content_is_present(expected_name) do |result|
      result[:author][:full_name].include?(expected_name)
    end
  end

  test "results contain tweet's author username" do
    expected_name = '@sumu_t93'
    assert_result_with_content_is_present(expected_name) do |result|
      result[:author][:username].include?(expected_name)
    end
  end

  test "results contain tweet's creation date" do
    expected_date = '1532204925000'
    assert_result_with_content_is_present(expected_date) do |result|
      result[:created_at].include?(expected_date)
    end
  end
end
