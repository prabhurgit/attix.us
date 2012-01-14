class MarkdownHighlighter
  include MarkdownWithSyntax

  @queue = :markdown_highlighter

  def self.perform(post_id)
    @post = Post.find(post_id)
    @content = markdown_with_syntax(@post.raw_content)
    post.update_attribute(:content => @content)
  end
end
