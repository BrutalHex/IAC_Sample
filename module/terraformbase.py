from module.shell import runShell
import shlex
import json

def formatFiles(terraformPathArgument ):
   return runShell(shlex.split(f'terraform {terraformPathArgument} fmt -write=true -recursive'),True)

def verifyInfra(terraformPathArgument  ):
    stdout, stderr=runShell(shlex.split(f'terraform {terraformPathArgument} init -backend=false'),True)
    if stderr:
         raise Exception(stderr)
    # terraform -chdir=./infra validate -json -no-color
    stdout, stderr=runShell(shlex.split(f'terraform {terraformPathArgument} validate -json -no-color'),True)
    return json.loads(stdout)

def initializeTerraform(terraformPathArgument    ):
    return runShell(['terraform' ,terraformPathArgument, 'init'],True)


def applyTerraform(terraformPathArgument  ,varfile):
    return runShell(['terraform' ,terraformPathArgument, 'apply',varfile,'-auto-approve'],True)

def getOutPut(terraformPathArgument,key):
    return runShell(shlex.split(f'terraform {terraformPathArgument} output -raw {key}'  ,True))


def createWorkspace(workspace):
    stdout, stderr=runShell(shlex.split(f'terraform workspace new {workspace}'),True)
    if stderr:
            raise Exception(stderr)

def initVarFiles(title,dir):
    stdout, stderr=runShell(shlex.split(f'touch {dir}/terraform-{title}.tfvars'),True)
    if stderr:
            raise Exception(stderr)

def selectWorkspace(workspace):
 
    stdout, stderr=runShell(shlex.split('terraform workspace list'),True)
    if stderr:
         raise Exception(stderr)
    stdout.replace('*','')
    definedWorkSpaces=stdout.split()
    if definedWorkSpaces.count(workspace)>0 :
        stdout, stderr=runShell(shlex.split(f'terraform workspace select {workspace}'),True)
        if stderr:
            raise Exception(stderr)
    else:
        createWorkspace(workspace)
