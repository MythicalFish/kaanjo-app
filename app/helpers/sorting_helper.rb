module SortingHelper

  def sort_link attribute, label
    
    direction = 'asc'
    link_class = 'sorter-desc'

    if params[:d] == 'asc'
      direction = 'desc'
      link_class = 'sorter-asc'
    end

    if params[:a] == attribute
      link_class << ' current'
    end
        
    url = url_replace(request.original_url,{d:direction,a:attribute})

    render partial: 'shared/sort_link', locals: {url:url,link_class:link_class,label:label}

  end

end  
