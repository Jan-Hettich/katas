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

  def self.from_cycle(c,n)
    p_array = (1..n).map do |i| 
      j = c.index(i)
      j ? c[(j+1)%c.length] : i
    end
    P.new *p_array
  end

  def cycles
    cycles = []
    bucket = array.clone
    while !bucket.empty? do
      cycle = []
      next_elt = bucket.min
      until cycle.include? next_elt do
        cycle << next_elt
        bucket -= [next_elt]
        next_elt = self[next_elt]
      end 
      cycles << cycle
    end
    cycles
  end

  def order
    cycles.reduce(0){|s,c| s += c.count - 1}
  end

  def sign
    order.even? ? "+" : "-"
  end

  protected

    attr_accessor :array

end
