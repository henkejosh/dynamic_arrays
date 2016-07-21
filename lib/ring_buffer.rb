require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(8)
    @start_index = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_index + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_index + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    val = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    self[@length - 1] = val
    nil
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    val, self[0] = self[0], nil
    @start_index = (@start_index + 1) % @capacity
    @length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_index = (@start_index - 1) % @capacity
    @length += 1
    self[0] = val
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
    if @length == @capacity
      new_ring = StaticArray.new(@capacity * 2)
      @length.times do |i|
        new_ring[i] = self[i]
      end
      @capacity *= 2
      @store = new_ring
      @start_index = 0
    end
  end
end
