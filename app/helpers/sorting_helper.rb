module SortingHelper

  def sort_link attribute, label
    
    direction = 'down'
    link_class = 'sorter-down'

    if params[:d] == 'down'
      direction = 'up'
      link_class = 'sorter-up'
    end

    if params[:a] == attribute
      link_class << ' current'
    end
        
    url = url_replace(request.original_url,{d:direction,a:attribute})

    render partial: 'shared/sort_link', locals: {url:url,link_class:link_class,label:label}

  end

end  
