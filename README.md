# ParallelEnum

Parallel enum is a very simple library for enumerating Enumerables on multiple threads.

## Installation

Add this line to your application's Gemfile:

    gem 'parallel_enum'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install parallel_enum

## Examples

```ruby
  require 'parallel_enum'
  require 'parallel_enum/core_ext/enumerable' # optional

  (1..10).in_parallel(5).map { |i| sleep 0.1; i }
  # => [1, 2, 3, 5, 4, 6, 7, 9, 10, 8]

  ParallelEnum.num_threads = 5
  (97..122).in_parallel.map(&:chr).map(&:upcase)
  # => [1, 2, 3, 5, 4, 6, 7, 9, 10, 8]

  require 'benchmark'
  puts Benchmark.measure { (1..10).each { sleep 1; } }
  # =>  0.000000   0.000000   0.000000 ( 10.001548)

  puts Benchmark.measure { (1..10).in_parallel(10) { sleep 1; } }
  # =>  0.000000   0.000000   0.000000 (  1.003057)

  require 'open-uri'
  page_load_times = Hash[
    %w(
      https://www.google.com
      https://www.apple.com
      https://www.facebook.com
    ).in_parallel(3).map do |url|
      [ url, Benchmark.measure{ open(url) }.real ]
    end
  ]
  # {"https://www.facebook.com"=>0.292943, "https://www.apple.com"=>0.514032, "https://www.google.com"=>0.582862}

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
