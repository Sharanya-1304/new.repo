# === Check if Node.js is already installed ===
node_installed = ::File.exist?('C:\\Program Files\\nodejs\\node.exe')

# === Install Node.js only if not installed ===
unless node_installed
  remote_file 'C:\\nodejs.msi' do
    source 'https://nodejs.org/dist/v18.18.2/node-v18.18.2-x64.msi'
    action :create
  end

  windows_package 'Node.js' do
    source 'C:\\nodejs.msi'
    installer_type :msi
    action :install
  end
else
  log 'Node.js already installed — skipping installation' do
    level :info
  end
end

# === Ensure app directory exists ===
directory 'C:\\new.repo\\app' do
  recursive true
  action :create
end

# === Copy application files ===
remote_directory 'C:\\new.repo\\app' do
  source 'app'
  files_backup 0
  action :create
end

# === Restart Node.js app ===
powershell_script 'Restart Node.js app' do
  code <<-EOH
    Stop-Process -Name node -ErrorAction SilentlyContinue
    Start-Process -FilePath "node" -ArgumentList "C:\\new.repo\\app\\server.js"
  EOH
end
