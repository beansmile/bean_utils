Rails.application.routes.draw do
  mount BeanUtils::Engine => "/bean_utils"
end
