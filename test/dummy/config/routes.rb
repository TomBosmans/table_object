Rails.application.routes.draw do
  mount TableObject::Engine => "/table_object"
end
