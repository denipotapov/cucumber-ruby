def contextPath = "ufr-cash/context/module-build/ufr-cash-cucumber.groovy"
def contextBranch = "project/ufr-cash"

def workflowContext
node {
    dir('ufr-jenkins-pipeline') {
        git url: 'ssh://git@git/ufr/ufr-jenkins-pipeline.git', branch: "${contextBranch}"
        workflowContext = load("${pwd()}/scripts/Workflow.groovy").prepareContext(contextPath)
    }
}
for(def stageContext : workflowContext.stages) {
    if(!stageContext.finished && !stageContext.skipped) {
        def nodeName = stageContext.node ?: ''
        println "===---  node [${nodeName}] locked  ---==="
        node(nodeName) {
            dir('ufr-jenkins-pipeline') {
                git url: 'ssh://git@git/ufr/ufr-jenkins-pipeline.git', branch: "${contextBranch}"
                def workflow = load("${pwd()}/scripts/Workflow.groovy").withBaseDir(pwd()).withContext(workflowContext)
                processStagesOnNode(nodeName, workflow, workflowContext)
            }
        }
        println "===--- node [${nodeName}] unlocked ---==="
    }
}
def processStagesOnNode(nodeName, workflow, workflowContext) {
    for(def stageContext : workflowContext.stages) {
        if(!stageContext.finished && !stageContext.skipped) {
            def requiredNodeName = stageContext.node ?: ''
            if(requiredNodeName != nodeName) {
                println "===--- unlock node [${nodeName}] due to required node ${requiredNodeName} ---==="
                return
            }
            println "===--- [${nodeName}] process stage started: ${stageContext.script} ---==="
            workflow.processStageContext(stageContext)
            println "===--- [${nodeName}] process stage finished: ${stageContext.script} ---==="
        }
    }
}