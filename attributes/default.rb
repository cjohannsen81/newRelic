case node['platform_family']
when 'windows'
  if node['kernel']['machine'] == 'x86_64'
    default['newRelic']['agent']['uri'] = 'http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x64_3.1.17.0.msi'
  else
    default['newRelic']['agent']['uri'] = 'http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x86_3.1.17.0.msi'
  end
when 'rhel'
  if node['kernel']['machine'] == 'x86_64'
    default['newRelic']['agent']['uri'] = 'http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm'
  end
end
