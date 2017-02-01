#!groovy

def compress(basename, files) {
    if (isUnix()) {
        def tarball = "${basename}.tar.gz"
        sh("tar caf \"${tarball}\" ${files}")
        return tarball
    } else {
        def zipfile = "${basename}.zip"
        bat("7z a -bd \"${zipfile}\" ${files}")
        return zipfile
    }
}

def gitDescribe() {
    if (isUnix()) {
        return sh(script: "git describe --long", returnStdout: true)
    } else {
        return bat(script: "@git describe --long", returnStdout: true)
    }
}

def setDisplayNameFromGit() {
    def gitDescription = gitDescribe()
    echo("git description: ${gitDescription}")
    currentBuild.displayName = "#${BUILD_NUMBER} ${gitDescription}"
}

def frogbuild(dstDir) {
    if (isUnix()) {
        sh("./frogbuild.sh ${dstDir}")
    } else {
        bat("call frogbuild.bat ${dstDir}")
    }
}

def pathSep() {
    return isUnix() ? '/' : '\\'
}

def buildTreefrog(platformSuffix) {
    def srcDir = pwd() + pathSep() + 's'
    def dstDir = pwd() + pathSep() + 'd'
    dir(dstDir) {
        deleteDir()
    }
    dir(srcDir) {
        checkout(scm)
        setDisplayNameFromGit()
        frogbuild(dstDir)
    }
    dir(dstDir) {
        def distSubdirs = isUnix() ? 'bin include lib share' : 'bin defaults include'
        archiveArtifacts(compress("treefrog-framework_${platformSuffix}", distSubdirs))
    }
}

stage('Windows x86') {
    node('windows && msvc14 && qtinstalls-windows') {
        buildTreefrog('windows_x86')
    }
}

stage('Linux x64') {
    node('wheezy64') {
        buildTreefrog('linux_x64')
    }
}
