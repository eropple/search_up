# SearchUp

`SearchUp` encapsulates an annoyingly common bit of code I keep writing for various projects (like [Boss](https://github.com/eropple/cfer-boss)) -- recursively searching upward for a file or directory. We see this all the time in Ruby command-line tools, searching for a `Gemfile` or a `Rakefile`, and everybody implements it themselves. Nobody implements it the same way twice, either. So I decided to take my preferred implementation and gem it up.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'search_up'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install search_up

## Usage

You can get a good feel for this library through its [test cases](https://github.com/eropple/search_up/blob/master/spec/search_up_spec.rb). The method signature, though, is as follows:

```ruby
SearchUp.search(start_at, pattern, stop_at: nil, find_one: false, &predicate)
```

`search` returns either an `Array` of `String` (which may be empty) or a single `String` if `find_one: true`.

- `start_at`: The directory in which to start searching.
- `pattern`: Either a String (glob) or a Regexp against which to test directory entries.
- `stop_at:`: Optional parameter. If set, the search will stop after reaching this directory. Any entries found in this directory _will_ be returned.
- `find_one:`: If true, returns only the first successful hit. Returns as a `String` rather than an array.
- `&predicate`: If a block (1-arity) is passed to this method, every file found by the pattern will be tested against it. Files for which this block returns false will be skipped.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eropple/search_up. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

