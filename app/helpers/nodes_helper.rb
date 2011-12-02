module NodesHelper
  def render_node_title(node_title)
    node = Node.find(node_title)
    link_to(node.title, node_path(node))
  end

end
