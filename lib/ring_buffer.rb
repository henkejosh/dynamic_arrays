require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[index] = val
  end

  # O(1)
  def pop
  end

  # O(1) ammortized
  def push(val)
  end

  # O(1)
  def shift
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    unless index < @length && index >= 0
      raise "index out of bounds"
    end
  end

  def resize!
  end
end
