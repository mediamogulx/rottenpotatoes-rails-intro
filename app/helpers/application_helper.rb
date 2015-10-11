module ApplicationHelper
    def sortable(column_name, title=nil)
       title ||= column_name.titleize
       css_class = column_name == params[:sort_by] ? "hilite" : nil
       link_to title, {:sort_by => column_name}, {:class => css_class}
    end
end
