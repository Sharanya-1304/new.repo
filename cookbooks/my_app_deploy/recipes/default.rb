# Ensure Chocolatey is installed
powershell_script 'install_chocolatey' do
  code <<-EOH
    if (!(Test-Path "$env:ProgramData\\chocolatey\\bin\\choco.exe")) {
      Set-ExecutionPolicy Bypass -Scope Process -Force
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
      iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
  EOH
end

# Install Node.js via Chocolatey
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
