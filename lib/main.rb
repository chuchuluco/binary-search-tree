require "./tree.rb"
require "./node.rb"

# Create a binary search tree from an array of random numbers'
random_array = Array.new(15) { rand(1..100) }

tree = Tree.new(random_array)

# Confirm that the tree is balanced by calling `#balanced?`'
puts tree.balanced?

# Print out all elements in level, pre, post, and in order'
puts 'Level Order:'
p tree.level_order

puts 'Pre Order:'
p tree.preorder

puts 'Post Order:'
p tree.postorder

puts 'In Order:'
p tree.inorder

# Try to unbalance the tree by adding several numbers > 100'
tree.insert(45)
tree.insert(35)
tree.insert(111)
tree.insert(190)

# Confirm that the tree is unbalanced by calling `#balanced?`'
puts tree.balanced?

# Balance the tree by calling `#rebalance!`'
tree.rebalance!

# Confirm that the tree is balanced by calling `#balanced?`'
puts tree.balanced?

# Print out all elements in level, pre, post, and in order'
puts 'Level Order:'
p tree.level_order

puts 'Pre Order:'
p tree.preorder

puts 'Post Order:'
p tree.postorder

puts 'In Order:'
p tree.inorder
