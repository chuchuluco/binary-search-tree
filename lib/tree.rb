require './main2.rb'
class Tree 
  attr_accessor :root
  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(@data)
  end

  private 
  def build_tree(array)
    return nil if array.empty?

    mid = (array.size - 1) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid + 1)..-1])

    root
  end

  public
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      leftmost_node = leftmost_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    node
  end

  def find(value, node = root)
    return node if node.nil? || node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end


  def leftmost_leaf(node)
    node = node.left until node.left.nil?

    node
  end

  def level_order(queue = [root])
    result = []
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : result << node.data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    result unless block_given?
  end

  def inorder(node = @root, output = [], &block)
    return if node.nil?

    inorder(node.left, output, &block)
    output.push(block_given? ? block.call(node) : node.data)
    inorder(node.right, output, &block)

    output
  end

  def preorder(node = @root, output = [], &block)
    return if node.nil?

    output.push(block_given? ? block.call(node) : node.data)
    preorder(node.left, output, &block)
    preorder(node.right, output, &block)

    output
  end

  def postorder(node = @root, output = [], &block)
    return if node.nil?

    postorder(node.left, output, &block)
    postorder(node.right, output, &block)
    output.push(block_given? ? block.call(node) : node.data)

    output
  end

  def height(node = @root)
    unless node.nil? || node == @root
      node = (node.instance_of?(Node) ? find(node.data) : find(node))
    end

    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end
  
end

array_num =  [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array_num)
tree.pretty_print
tree.insert(45)
tree.pretty_print
tree.delete(45)
tree.pretty_print
p tree.level_order
