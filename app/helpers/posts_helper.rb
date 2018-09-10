module PostsHelper
  def title_to_link(post)
    link_to(post.title, post.url, target: :_blank )
  end
end
