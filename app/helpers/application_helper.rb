# coding: utf-8
module ApplicationHelper
  class BootstrapLinkRenderer < ::WillPaginate::ViewHelpers::LinkRenderer
      protected

      def html_container(html)
        tag :div, tag(:ul, html), container_attributes
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class =>
        ('active' if page == current_page)
      end

      def gap
        tag :li, link(super, '#'), :class => 'disabled'
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3],
          classname, ('disabled' unless page)].join(' ')
      end
    end


  def custom_will_paginate(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '上一页'.html_safe, :next_label => '下一页'.html_safe)
  end



end
