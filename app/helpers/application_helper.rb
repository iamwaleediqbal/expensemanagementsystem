module ApplicationHelper
    def active_class(path)
        p request.path
        if request.path == path
          return 'active'
        else
          return ''
        end
      end
end
