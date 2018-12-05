#
# Cookbook:: user
# Recipe:: groups
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe "user::default"

search("group", "*:*").each do |group_data|
  group group_data["id"] do
    gid group_data["gid"]
    members group_data["members"]
  end
end

