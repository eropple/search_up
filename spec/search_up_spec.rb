# frozen_string_literal: true

require "spec_helper"

describe SearchUp do
  it "has a version number" do
    expect(SearchUp::VERSION).not_to be nil
  end

  it "can find a file in its local" do
    f = SearchUp.search(test_content_path("foo/bar"), "boop.txt", find_one: true)

    expect(f).to eq test_content_path("foo/bar/boop.txt")
  end

  it "can find a file at a higher level" do
    f = SearchUp.search(test_content_path("foo/bar"), "bang.txt", find_one: true)

    expect(f).to eq test_content_path("bang.txt")
  end

  it "can find files when globbing" do
    f = SearchUp.search(test_content_path("foo/bar"), "b*p.txt")

    expect(f).to eq [
      test_content_path("foo/bar/boop.txt"),
      test_content_path("foo/beep.txt"),
      test_content_path("foo/boop.txt")
    ]
  end

  it "can find files when regexing" do
    f = SearchUp.search(test_content_path("foo/bar"), /b[eo]{2}p.txt/)

    expect(f).to eq [
      test_content_path("foo/bar/boop.txt"),
      test_content_path("foo/beep.txt"),
      test_content_path("foo/boop.txt")
    ]
  end

  it "can return the empty set with no files" do
    f = SearchUp.search(test_content_path("foo/bar"), "bang.txt", stop_at: test_content_path("foo"))

    expect(f).to eq([])
  end

  it "returns nil with no files if find_one: true" do
    f = SearchUp.search(test_content_path("foo/bar"), "bang.txt", stop_at: test_content_path("foo"), find_one: true)

    expect(f).to eq(nil)
  end

  it "filters by predicate" do
    f = SearchUp.search(test_content_path("foo/bar"), "*.txt", stop_at: test_content_path(".")) { |f| File.file?(f) }

    expect(f.length).to eq 3

    f2 = SearchUp.search(test_content_path("foo/bar"), "*.txt", stop_at: test_content_path(".")) { |f| File.directory?(f) }

    expect(f2.length).to eq 0
  end
end
