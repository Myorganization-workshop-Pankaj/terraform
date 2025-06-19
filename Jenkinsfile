pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello, World!'
                script{
                  def services = GlobalDetectChangedServices()
                  println services
            }
        }
    }
}
}


def GlobalDetectChangedServices() {
    // Scripted Pipeline
    def changedFiles = []
    def changedServices = []

    if (BRANCH_NAME ==~ /PR-.*$/){
        changedFiles = sh(
            script: "git --no-pager diff origin/${env.CHANGE_TARGET} --name-only",
            returnStdout: true
        ).split('\n').toList()

        println changedFiles
    }
    else{
        for (changeLogSet in currentBuild.changeSets) {
            for (entry in changeLogSet.getItems()) { // for each commit in the detected changes
                for (file in entry.getAffectedFiles()) {
                    changedFiles += file.getPath() // add changed file to list
                }
            }
        }
    }

    for (changedService in changedFiles.unique()) {

        def regex = "(us|ap|eu|east|west|central)-?.*/.*/.*/.*"
        if (changedService =~ /${regex}/) {
            changedServices += changedService.split('/').toList().subList(0, 3).join('/')
        }
    }

    return changedServices.unique()
}
