#
# Cookbook Name: clouderamanager
# Recipe: cm-masternamenode.rb
#
# Copyright (c) 2011 Dell Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'clouderamanager::cm-client'

#######################################################################
# Begin recipe
#######################################################################
debug = node[:clouderamanager][:debug]
Chef::Log.info("CM - BEGIN clouderamanager:cm-masternamenode") if debug

# Configuration filter for our crowbar environment.
env_filter = " AND environment:#{node[:clouderamanager][:config][:environment]}"

# Add the master name node UI link to the crowbar UI.
Chef::Log.info("CM - hadoop master name node {" + node[:fqdn] + "}") if debug 
server_ip = BarclampLibrary::Barclamp::Inventory.get_network_by_type(node,"admin").address
node[:crowbar] = {} if node[:crowbar].nil? 
node[:crowbar][:links] = {} if node[:crowbar][:links].nil?
if server_ip
  url = "http://#{server_ip}:50070" 
  Chef::Log.info("CM - Hadoop Name Node UI [#{url}]") if debug 
  node[:crowbar][:links]["Hadoop Name Node UI"] = url 
else
  node[:crowbar][:links].delete("Hadoop Name Node UI")
end

#######################################################################
# End of recipe
#######################################################################
Chef::Log.info("CM - END clouderamanager:cm-masternamenode") if debug
