pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out source code..."
                git branch: 'main', url: 'https://github.com/Sharanya-1304/new.repo.git'
            }
        }
        stage('Deploy with Chef') {
            steps {
                echo "Running Chef deployment..."
                bat '''
                cd "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Jenkins with Chef"
                "C:/opscode/chef-workstation/bin/chef-client.bat" --local-mode --chef-license accept ^
                --config-option cookbooks_path=C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Jenkins with Chef\\cookbooks ^
                --runlist "recipe[my_app_deploy::default]"
                '''
            }
        }
    }
    post {
        success { echo "Deployment successful!" }
        failure { echo "Deployment failed! Check Chef logs for details." }
    }
}
