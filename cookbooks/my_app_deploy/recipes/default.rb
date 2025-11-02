#
# Cookbook:: my_app_deploy
# Recipe:: default
#
# Copyright:: 2025, Sharanya, All Rights Reserved.

# Check if Node.js is installed
nodejs_installed = system('where node > nul 2>&1')

if nodejs_installed
  log 'Node.js already installed — skipping installation' do
    level :info
  end
else
  log 'Installing Node.js...' do
    level :info
  end
  
  # Download and install Node.js
  powershell_script 'install_nodejs' do
    code <<-EOH
      $url = "https://nodejs.org/dist/v18.18.0/node-v18.18.0-x64.msi"
      $output = "C:\\temp\\nodejs.msi"
      New-Item -ItemType Directory -Force -Path C:\\temp
      Invoke-WebRequest -Uri $url -OutFile $output
      Start-Process msiexec.exe -Wait -ArgumentList '/i C:\\temp\\nodejs.msi /quiet /norestart'
    EOH
    action :run
  end
end

# Create application directory
directory 'C:\\new.repo' do
  recursive true
  action :create
end

# Clone or update the application repository
git 'C:\\new.repo\\app' do
  repository 'https://github.com/Sharanya-1304/new.repo.git'
  revision 'main'
  action :sync
end

# Install Node.js dependencies
execute 'npm_install' do
  command 'npm install'
  cwd 'C:\\new.repo\\app'
  only_if { ::File.exist?('C:\\new.repo\\app\\package.json') }
end

# Create a simple start script
file 'C:\\new.repo\\app\\start.bat' do
  content <<-EOH
@echo off
cd /d C:\\new.repo\\app
npm start
  EOH
  action :create
end

log 'Deployment completed successfully!' do
  level :info
end
