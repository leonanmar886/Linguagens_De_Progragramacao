defmodule TreeNode do
  defstruct key: 0, val: 0, left: nil, right: nil

  def tree(key, val, left, right) do
    %TreeNode{key: key, val: val, left: left, right: right}
  end
end

defmodule DepthFirst do
  @scale 30

  def depthFirst(nil, _level, _leftLim, _root_x, _rightLim) do
    {nil, 0.0, 0.0}
  end

  def depthFirst(%TreeNode{key: key, val: val, left: l, right: r}, level, leftLim, root_x, rightLim) do
    y = @scale * level

    case {l, r} do
      {nil, nil} ->
        x = root_x
        rightLim = root_x
        leftLim = root_x
      {l, nil} ->
        x = root_x
        depthFirst(l, level + 1, leftLim, root_x, rightLim)
      {nil, r} ->
        x = root_x
        depthFirst(r, level + 1, leftLim, root_x, rightLim)
      {l, r} ->
        {l_node, lroot_x, lrightLim} = depthFirst(l, level + 1, leftLim, root_x, rightLim)
        rleftLim = lrightLim+@scale
        {r_node, rroot_x, _} = depthFirst(r, level + 1, rleftLim, rleftLim, rightLim)
        x = (lroot_x + rroot_x) / 2
    end
    IO.inspect({ %{key: key, val: val}, x, y })
    #{ %{key: key, val: val}, x, y }
  end
end

# Correção na definição da árvore
tree =
  TreeNode.tree(:a, 111,
    TreeNode.tree(:b, 55,
      TreeNode.tree(:x, 100,
        TreeNode.tree(:z, 56, nil, nil),
        TreeNode.tree(:w, 23, nil, nil)
      ),
      TreeNode.tree(:y, 105, nil,
        TreeNode.tree(:r, 77, nil, nil)
      )
    ),
    TreeNode.tree(:c, 123,
      TreeNode.tree(:d, 119,
        TreeNode.tree(:g, 44, nil, nil),
        TreeNode.tree(:h, 50,
          TreeNode.tree(:i, 5, nil, nil),
          TreeNode.tree(:j, 6, nil, nil)
        )
      ),
      TreeNode.tree(:e, 133, nil, nil)
    )
  )

# Correção na chamada da função
fun = DepthFirst.depthFirst(tree, 1, 30, 0, 0)

IO.inspect(fun)
