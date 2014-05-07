# Permuatation - rearrangment of {1,..,n}
#  or a "bijective mapping" of {1,..,n} to itself
# Cycle - cyclical permutation that may move only
#  a subset of elements; e.g  1->5, 5->2, 2->1

class P

  def initialize(size, map)
    @size = size
    @map = map
  end

  def self.from_cycle(n,c)
    P.new n, ->(x) do
      j = c.index(x)
      j ? c[(j+1)%c.size] : x
    end
  end

  def to_a
    (1..size).map(&map)
  end

  def [](x)
    map.call(x)
  end

  def compose(first)
    #assume sizes are the same
    P.new size, ->(x){map[first.map[x]]}
  end
  alias * compose

  def cycles
    cycles = []
    bucket = (1..size).to_a
    # (1..size).each do |x|
    #   next if self[x] != x
    #   cycles << [x]
    #   bucket -= [x]
    # end
    # now deal with the bucket
    while !bucket.empty?
      cycle = []
      next_elt = bucket[0]
      begin
        cycle << next_elt
        bucket -= [next_elt]
        next_elt = self[next_elt]
      end until cycle.include? next_elt
      cycles << cycle
    end
    cycles
  end

  attr_reader :size, :map

end