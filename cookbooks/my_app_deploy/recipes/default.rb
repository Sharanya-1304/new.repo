# Simple Chef recipe to deploy your Node.js app

# Install Node.js (Windows-safe method)
windows_package 'Node.js' do
  source 'https://nodejs.org/dist/v18.18.2/node-v18.18.2-x64.msi'
  installer_type :msi
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
