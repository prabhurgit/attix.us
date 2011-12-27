# coding: utf-8
module UsersHelper
  def user_name_tag(user,options = {})
    return "匿名" if user.blank?
    result = link_to(user.name, user_path(user))
    #result = user.name
    return result
  end

  def user_avatar_tag(user,size = :normal, opts = {})
    link = opts[:link] || true
    width = 48
    case size
    when :normal
      width = 48
    when :small
      width = 16
    when :large
      width = 128
    else
      width = size
    end

    hash = (user.blank? or user.email.blank?) ? Digest::MD5.hexdigest("") : Digest::MD5.hexdigest(user.email)
    return image_tag("http://www.gravatar.com/avatar/#{hash}.png?s=#{width}&d=identicon")  if user.blank?

    img_src = "http://www.gravatar.com/avatar/#{hash}.png?s=#{width}&d=identicon"
    img = image_tag(img_src, :style => "width:#{width}px;height:#{width}px;")
    html = ""
    #if link
    #  html = %(<a href="#{user_path(user.email)}" #{user_popover_info(user)} class="user_avatar">#{img}</a>)
    #else
    #  html = img
    #end
    #raw html
    img
  end
end
