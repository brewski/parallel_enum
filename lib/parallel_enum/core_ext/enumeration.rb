require "parallel_enum"

module Enumerable
  def in_parallel(num_threads = nil, &block)
    ParallelEnum.new(self, num_threads).tap do |enum|
      enum.each(&block) if (block_given?)
    end
  end
end