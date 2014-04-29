require "parallel_enum/version"
require "agent"

class ParallelEnum < Enumerator
  class << self
    attr_accessor :num_threads
  end

  def initialize(src, num_threads = nil)
    num_threads ||= self.class.num_threads
    unless (Integer === num_threads)
      raise ArgumentError.new("Invalid number of threads for parallel enumeration: #{num_threads.inspect}")
    end

    super() do |yielder|
      channel = Agent::Channel.new(Object)
      threads = num_threads.times.map do
        Agent.go! do
          while (channel.open?)
            obj, success = channel.receive
            yielder << obj if (success)
          end
        end
      end

      src.each(&channel.method(:send))
      channel.close
      threads.each(&:join)
      self
    end
  end
end