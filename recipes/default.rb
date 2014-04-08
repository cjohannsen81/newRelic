#
# Cookbook Name:: newRelic
# Recipe:: default
#
# Copyright 2014, Christian Johannsen
#
# All rights reserved - Do Not Redistribute
#
#

case node['platform_family']
when 'windows'
  if node['kernel']['machine'] == 'x86_64'
	# creates the remote file
	remote_file "C:/chef/NewRelicServerMonitor_x64_3.1.17.0.msi" do
	  source node['newRelic']['agent']['uri']
	  action :create
	end
	# installs the package and add the license
	windows_package "New Relic Monitoring" do
 	  #source "C:/chef/NewRelicServerMonitor_x64_3.1.17.0.msi"
  	  source node['newRelic']['agent']['tempUri']
	  installer_type :msi
  	  action :install
  	  options "NR_LICENSE_KEY=#{node['newRelic']['agent']['license']}"
  	end
	# starts the windows service
	service "new relic service" do
  	  service_name "nrsvrmon"
  	  action :start
	end
  end
when 'rhel'
	# creates temporary file
	remote_file "/tmp/newrelic-repo-5-3.noarch.rpm" do
  	  source node['newRelic']['agent']['uri'] 
	  mode "777"
	  action :create
	end
  	# adds the package to the manager
	rpm_package "New Relic Monitoring" do
    	  #source "/tmp/newrelic-repo-5-3.noarch.rpm"
    	  source node['newRelic']['agent']['tempUri']
	  action :install
	end
	# installs the package from the package manager
	package "newrelic-sysmond" do
	  action [:install]
	end
	# configures the license
	execute "newrelic-config" do
	  command "nrsysmond-config --set license_key=#{node['newRelic']['agent']['license']}"
	end
	# starts the service
	service "newrelic-sysmond" do
	  action [ :enable, :start ]
	end
end
