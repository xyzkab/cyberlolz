module PostsHelper
  def link_to_post(post)
    link_to(post.title[0..50], post_path(post))
  end
  def title_to_link(post)
    link_to(post.title, post.url, target: :_blank )
  end
end
