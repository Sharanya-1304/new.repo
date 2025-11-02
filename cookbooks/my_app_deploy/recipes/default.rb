# === Install Node.js directly via MSI ===
remote_file 'C:\\nodejs.msi' do
  source 'https://nodejs.org/dist/v18.18.2/node-v18.18.2-x64.msi'
  action :create
end

windows_package 'Node.js' do
  source 'C:\\nodejs.msi'
  installer_type :msi
  action :install
end

# === Ensure deployment directory exists ===
directory 'C:\\new.repo\\app' do
  recursive true
  action :create
end

# === Copy app source ===
remote_directory 'C:\\new.repo\\app' do
  source 'app'
  files_backup 0
  action :create
end

# === Start Node.js server ===
powershell_script 'Start Node.js app' do
  code <<-EOH
    Stop-Process -Name node -ErrorAction SilentlyContinue
    Start-Process -FilePath "node" -ArgumentList "C:\\new.repo\\app\\server.js"
  EOH
end
