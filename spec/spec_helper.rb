# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "search_up"

def test_content_path(subpath = "")
  File.expand_path(subpath, File.expand_path("test_content", __dir__))
end
