# Permuatation - rearrangment of {1,..,n}
#  or a "bijective mapping" of {1,..,n} to itself
# Cycle - cyclical permutation that may move only
#  a subset of elements; e.g  1->5, 5->2, 2->1

class P

  @@size =5

  def self.size
    @@size
  end

  def self.from_cycle(c)
    P.new ->(x) do
      j = c.index(x)
      j ? c[(j+1)%c.size] : x
    end
  end

  def initialize(f)
    @f = f
  end

  def to_a
    (1..@@size).map(&f)
  end

  def [](x)
    f.call(x)
  end

  def compose(g)
    P.new(->(x){f[g[x]]})
  end
  alias * compose

  attr_accessor :f

end