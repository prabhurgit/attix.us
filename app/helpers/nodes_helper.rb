module NodesHelper
  def render_node_name(node_id)
    node = Node.find(node_id)
    link_to(node.title, node_path(node))
  end

end
