module NodesHelper
  def render_node_title(node)
    link_to(node.title, node_path(node))
  end

end
