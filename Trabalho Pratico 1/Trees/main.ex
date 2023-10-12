defmodule Tree do
  defstruct key: 0, val: 0, left: nil, right: nil

  def tree(key, val, left, right) do
    %Tree{key: key, val: val, left: left, right: right}
  end
end

defmodule DepthFirst do
  @scale 30

  defstruct tree: nil, rootX: nil, rightLim: nil
  
  def depthFirst(tree, level, leftLim) do
    y = @scale * level
    
    case tree do
    
      %Tree{left: nil, right: nil} ->
        x = root_x = rightLim = leftLim
        IO.inspect({ tree.key, tree.val, x, y })
        {root_x, rightLim}
        
      %Tree{left: %Tree{}, right: nil} ->
        { root_x, rightLim} = depthFirst(tree.left, level + 1, leftLim)
        x = root_x
        IO.inspect({tree.key, tree.val, x, y })
        { root_x, rightLim}
        
      %Tree{left: nil, right: %Tree{}} ->
        {root_x, rightLim} = depthFirst(tree.right, level + 1, leftLim)
        x = root_x
        IO.inspect({tree.key, tree.val, x, y })
        {root_x, rightLim}
        
      %Tree{left:  %Tree{}, right: %Tree{}} ->
        {lroot_x, lrightLim} = depthFirst(tree.left, level + 1, leftLim)
        rleftLim = lrightLim + @scale
        {rroot_x, rrightLim} = depthFirst(tree.right, level + 1, rleftLim)
        x = (rroot_x + lroot_x) / 2
        IO.inspect({tree.key, tree.val, x, y })
        {x, rrightLim}
    end
  end
end

tree =
  Tree.tree(:a, 111,
    Tree.tree(:b, 55,
      Tree.tree(:x, 100,
        Tree.tree(:z, 56, nil, nil),
        Tree.tree(:w, 23, nil, nil)
      ),
      Tree.tree(:y, 105, nil,
        Tree.tree(:r, 77, nil, nil)
      )
    ),
    Tree.tree(:c, 123,
      Tree.tree(:d, 119,
        Tree.tree(:g, 44, nil, nil),
        Tree.tree(:h, 50,
          Tree.tree(:i, 5, nil, nil),
          Tree.tree(:j, 6, nil, nil)
        )
      ),
      Tree.tree(:e, 133, nil, nil)
    )
  )
DepthFirst.depthFirst(tree, 1, 30)