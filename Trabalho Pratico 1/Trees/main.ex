defmodule Tree do
  defstruct key: 0, val: 0, left: nil, right: nil

  def tree(key, val, left, right) do
    %Tree{key: key, val: val, left: left, right: right}
  end

  def leaf do
    :leaf
  end
end

defmodule DepthFirst do
  @scale 30

  defstruct tree: nil, rootX: nil, rightLim: nil

  def depthFirst(%Tree{key: key, val: val, left: l, right: r}, level, leftLim, root_x, rightLim) do
    y = @scale * level
    defstruct tree: nil, rootX: nil, rightLim: nil

    case tree do
      %Tree{left: :leaf, right: :leaf} ->
        x = root_x
        rightLim = root_x
        leftLim = root_x
      %Tree{left: %Tree{}, right: :leaf} ->
        x = root_x
        depthFirst(l, level + 1, leftLim, root_x, rightLim)
      %Tree{left: :leaf, right: %Tree{}} ->
        x = root_x
        depthFirst(r, level + 1, leftLim, root_x, rightLim)
      %Tree{left:  %Tree{}, right: %Tree{}} ->
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

# Correção na chamada da função
fun = DepthFirst.depthFirst(tree, 1, 30, 0, 0)

IO.inspect(fun)
