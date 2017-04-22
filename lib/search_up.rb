# frozen_string_literal: true
require "search_up/version"

module SearchUp
  def self.search(start_at, pattern, stop_at: nil, find_one: false, &predicate)
    raise "start_at must be a String" unless start_at.is_a?(String)
    raise "pattern must be a String or a Regexp" \
      unless pattern.is_a?(String) || pattern.is_a?(Regexp)

    raise "stop_at must be nil or a String" \
      unless stop_at.nil? || stop_at.is_a?(String)

    find_one = !!find_one

    ret = []

    start_directory = File.expand_path(start_at)
    stop_directory = stop_at.nil? ? nil : File.expand_path(stop_at)

    previous = nil
    current = start_directory
    until current.nil? || current == previous
      candidates =
        if pattern.is_a?(String)
          Dir[File.join(current, pattern)]
        else
          Dir[File.join(current, "*")].grep(pattern)
        end

      candidates.select!(&predicate) unless predicate.nil?

      return candidates.first if find_one && !candidates.first.nil?

      ret << candidates

      previous = current
      current = File.expand_path("..", previous)

      break if current == stop_directory
    end

    # implicit; we can't get here in the find_one path unless we haven't found one
    find_one ? nil : ret.flatten
  end
end
