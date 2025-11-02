# Simple Chef recipe to deploy Node.js app on Windows

# Install Node.js via Chocolatey (most reliable)
chocolatey_package 'nodejs-lts' do
  action :install
end

# Ensure app directory exists
directory 'C:\new.repo\app' do
  recursive true
  action :create
end

# Copy app code to deployment directory
remote_directory 'C:\new.repo\app' do
  source 'app'
  files_backup 0
  action :create
end

# Start the Node.js server
powershell_script 'Start Node.js app' do
  code <<-EOH
    Stop-Process -Name node -ErrorAction SilentlyContinue
    Start-Process -FilePath "node" -ArgumentList "C:\\new.repo\\app\\server.js"
  EOH
end
