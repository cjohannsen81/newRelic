#
# Cookbook Name:: newRelic
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

case node['platform_family']
when 'windows'
  if node['kernel']['machine'] == 'x86_64'
	remote_file "C:/chef/NewRelicServerMonitor_x64_3.1.17.0.msi" do
	  source node['newRelic']['agent']['uri']
	  action :create
	end
	windows_package "New Relic Monitoring" do
 	  source "C:/chef/NewRelicServerMonitor_x64_3.1.17.0.msi"
  	  installer_type :msi
  	  action :install
  	  options "NR_LICENSE_KEY=fca354a023a28874174ae9490c44d169e33772f6"
  	end
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
    	  source "/tmp/newrelic-repo-5-3.noarch.rpm"
    	  action :install
	end
	package "newrelic-sysmond" do
	  action [:install]
	end
	execute "newrelic-config" do
	  command "nrsysmond-config --set license_key=fca354a023a28874174ae9490c44d169e33772f6"
	end
	service "newrelic-sysmond" do
	  action [ :enable, :start ]
	end
end
