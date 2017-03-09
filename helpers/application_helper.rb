module ApplicationHelpers
  def current?(path='/')
    request.path_info == path ? 'current' :  nil
  end
end

