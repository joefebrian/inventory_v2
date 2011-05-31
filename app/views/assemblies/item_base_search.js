<% ActiveRecord::Base.include_root_in_json = false %>
<%= @assemblies.to_json(:methods => :item_name_with_assembly) %>
