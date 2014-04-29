# ParallelEnum

Parallel enum is a very simple library for processing Enumerables on multiple threads.

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

  enum = ParallelEnum.new(10.times, 5)
  enum.each { |i| sleep rand; print i }
  # => 0365482179

  require 'parallel_enum/core_ext/enumerable'
  (1..10).in_parallel(5).map { |i| sleep 0.1; i * 2 }
  # => [2, 6, 4, 8, 10, 12, 14, 16, 18, 20]

  ParallelEnum.num_threads = 10
  require 'benchmark'
  puts Benchmark.measure { (1..10).each { sleep 1; } }
  # =>  0.000000   0.000000   0.000000 ( 10.001548)
  puts Benchmark.measure { (1..10).in_parallel { sleep 1; } }
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
