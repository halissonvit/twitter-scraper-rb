# frozen_string_literal: true

require 'open-uri'

USER_AGENT_WITH_JS_SUPPORT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) '\
'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'

module Browser
  # Simple browser implementation that provides methods to
  # open an url and fetch the source of the page.
  class SimpleBrowser
    attr_reader :html, :url

    def open_url(url, custom_headers = {})
      raise ArgumentError, 'invalid url' unless url =~ URI.regexp(%w[http https])

      @url = url
      @html = open(@url, default_headers.merge(custom_headers))
    end

    private

    def default_headers
      { 'user-agent' => USER_AGENT_WITH_JS_SUPPORT }
    end
  end
end
