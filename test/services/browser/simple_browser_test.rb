# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'
require_relative '../../../app/services/browser/simple_browser'

class SimpleBrowserTest < ActiveSupport::TestCase
  def setup
    @browser = Browser::SimpleBrowser.new
  end

  test 'open_url tries to open an url' do
    url = 'https://twitter.com/search?q=MLHLocalhost'
    mock_open = MiniTest::Mock.new
    mock_open.expect :call, nil, [url, Hash]

    @browser.stub :open, mock_open do
      @browser.open_url(url)
    end

    mock_open.verify
  end

  test 'open_url expects a valid url' do
    url = 'invalid'
    assert_raises ArgumentError do
      @browser.open_url(url)
    end
  end
end
