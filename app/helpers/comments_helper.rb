module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render(comment) + 
        content_tag(:div, render(comment.children.order(:created_at)), :class => "nested_comments")
    end.join.html_safe
  end
end
