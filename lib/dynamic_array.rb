require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(10)
    @capacity = 10
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if index < @length
      return @store[index]
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def []=(index, value)
    if index < @capacity
      @store[index] = value
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @store[@length - 1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length >= @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    val = self[0]

    @length.times do |idx|
      next if idx == @start_idx
      @store[idx - 1] = @store[idx]
    end
    @length -= 1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    (@length - 1).downto(1) do |idx|
      @store[idx] = @store[idx - 1]
    end
    @store[0] = val
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
