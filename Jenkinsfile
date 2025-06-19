pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                script {
                    def services = GlobalDetectChangedServices()
                    echo "Changed Services: ${services}"
                }
            }
        }
    }
}

def GlobalDetectChangedServices() {
    def changedFiles = []
    def changedServices = []

    if (env.BRANCH_NAME ==~ /PR-.*/) {
        changedFiles = sh(
            script: "git --no-pager diff origin/${env.CHANGE_TARGET} --name-only",
            returnStdout: true
        ).trim().split('\n') as List
        echo "Changed files in PR: ${changedFiles}"
    } else {
        for (changeLogSet in currentBuild.changeSets) {
            for (entry in changeLogSet.items) {
                for (file in entry.affectedFiles) {
                    changedFiles << file.path
                }
            }
        }
        echo "Changed files in commit: ${changedFiles}"
    }

    for (changedService in changedFiles.unique()) {
        def regex = "(us|ap|eu|east|west|central)-?.*/.*/.*/.*"
        if (changedService ==~ /${regex}/) {
            changedServices << changedService.split('/').take(3).join('/')
        }
    }

    return changedServices.unique()
}
