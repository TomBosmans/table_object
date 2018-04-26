class UserTable < TableObject::Base
  self.default_path = ->(user) { url_helper.user_path(user) }

  column :email,
         type: :email,
         path: ->(user) { user.email }

  column :name,
         value_method: ->(user) { "#{user.first_name} #{user.last_name}" }

  column :birth_date
  column :log_in_count

  table_action :new,
               label: 'NEW',
               path: url_helper.new_user_path

  resource_action :edit,
                  label: 'EDIT',
                  path: ->(user) { url_helper.edit_user_path(user) }

  resource_action :destroy,
                  label: 'DESTROY',
                  path: ->(user) { url_helper.user_path(user) },
                  method: :destroy
end
