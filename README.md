# TableObject

## Goal :shipit:
* Keep most logic out of the views, no one wants to go through a view with a 100 if statements.
* Keep it DRY.

## Usage :hammer:

### Table partial.
The first thing to do is create a partial that will render the tables. This is not included in the gem because this will differ for each application.

Example:
```erb
<header>
  <% table.table_actions.each do |table_action| %>
    <%= button_to table_action.label, table_action.path %>
  <% end %>
</header>

<table id="<%= table.name %>">
  <tr>
    <% table.columns.each do |column| %>
      <th class="<%= column.type %>"><%= column.label %></th>
    <% end %>
    <th>-</th>
  </tr>

  <% table.resources.each do |resource| %>
    <tr id="resource-<%= resource.id %>">
      <% table.columns.each do |column| %>
	<td class="<%= column.type %>">
	  <%= link_to column.path_for(resource) do %>
	    <%= column.value_for(resource) %>
	  <% end %>
	</td>
      <% end %>

      <td>
	<% table.resource_actions.each do |resource_action| %>
	  <%= link_to resource_action.label, resource_action.path.call(resource) %>
	<% end %>
      </td>
    </tr>
  <% end %>
</table>
```
### TableObject
create a table object in for example `app/table_objects/`
```ruby
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
```
#### Table
* `.default_path`: if table has a default path this will be used for all columns, unless they have a path assigned.
* `.model_class`: by default this will try to guess the model class based on the table name by removing the "Table" substring. UserTable => User
* `.default_path`: this path will be filled in all columns of the table by default. can be overridden by given your column a path.
* `.column`: Will create a column object for the table.
* `.table_action`: Will create action object for the table. This are actions that have to do with the table as a whole. New, Export, ...
* `.resource_action`: Will create action object for the table. this are actions that have to do with the resource. Edit, Show, Destroy
* The type on a column, if not given, is filled in by default based on db info. This uses `model_class`.
* `#name`: by default this is the table class name in snakecase, but can be set.
* `#resources`: This is what you pass in the table. this can be collection of users, books, movies,...

#### Column
* `#value_for(resource)`: If a lambda is given for `value_method`, this will be called. If no `value_method` is present it will public_send the column name on the given resource.
* `#path_for(resrouce)`: Will return the path for the given resource.
* custom options: All options are stored `options` hash. You can also call these as if they where attributes. Example: ```
test_column = TableObject::Column.new(:test_column, 'test?' => true);
test_column.test? # => true ```
#### Action
* This object is used for table_actions and resource_actions.
* Also has custom options like columns

### Controller:
```ruby
class UsersController < ApplicationController
  def index
    users = User.all
    @user_table = UserTable.new(users)
  end
end
```
### View:
```erb
<%= render 'shared/table', table: @user_table %>
```
## :warning: Warning :warning:
If you access attributes from nested relationships you can create N+1 queries. Prevent these by using `include` or `eager_load`.
For more info you can read [this](http://blog.scoutapp.com/articles/2017/01/24/activerecord-includes-vs-joins-vs-preload-vs-eager_load-when-and-where)
```ruby
def index
  users = User.includes(:address)
  @user_table = UserTable.new(users)
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'table_object'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install table_object
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
