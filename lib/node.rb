class Node 
  include Comparable

  def initialize(data= nil, root= nil, left= nil, right= nil)
    @data = data
    @root = root
    @left = left
    @right = right
  end
end
