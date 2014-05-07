# KATA - 

class P

  def initialize(*args)
    @array = args
    raise "not a valid permutation" unless 
      array.to_set == (1..array.size).to_set      
  end

  def size
    array.length
  end

  def initialize_copy(orig)
    @array = orig.array.dup
  end

  def to_s
    "P:#{array.to_s}"
  end

  def resize!(n)
    raise "cannot resize smaller" if n < size
    ((size+1)..n).inject(array){|a,i| a << i}
    self
  end

  def resize(n)
    self.dup.resize!(n)
  end

  def ==(other)
    raise "unexpected type" unless other.is_a? P
    array == other.array
  end

  def ===(other)
    max_size = [self.size, other.size].max
    self.resize(max_size) == other.resize(max_size)
  end

  def [](i)
    array[i-1]
  end

  def to_proc
    ->(i){self[i]}
  end

  def compose(first)
    P.new(*(1..array.size).map(&first).map(&self))     
  end

  protected

    attr_accessor :array

end


class C

end