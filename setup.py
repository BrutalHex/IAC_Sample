from module.shell import *
from module.terraformbase import *
import json
import re
 
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


terraformPathArgument= '-chdir=./infrastructure'

options=[(1,'development'),(2,'preview'),(3,'live')]
for option in options:
   initVarFiles(option[1],'./infrastructure')


for option in options:
    print(f'for {option[1]} enter {option[0]}')

userChoice=str(input('choose your Item:'))

if userChoice == '':
    userChoice='1'

match=re.search(r'[1-3]{1}',userChoice)
if not match :
    raise Exception('enter valid number')


userChoice=int(userChoice)


item= [opt[1] for opt in options if opt[0]==userChoice]

variable=str(item[0])

variableFileName=f'terraform-{variable}.tfvars'

#-var-file

print(f'the script will use : {variableFileName}')

varArg= f'-var-file={variableFileName}'

selectWorkspace(variable)


#format
stdout, stderr=formatFiles(terraformPathArgument)
if stderr:
    raise Exception(stderr)

# verify 
parsedOutput=verifyInfra(terraformPathArgument)

 

if not bool(parsedOutput["valid"]):
    print(f'{bcolors.FAIL}{json.dumps(parsedOutput, indent=4)}{bcolors.ENDC}')
    raise SystemExit(0)



# initialize the terraform modules
stdout, stderr =initializeTerraform(terraformPathArgument)
print( stdout )


#apply and create infrastructue:
stdout, stderr =applyTerraform(terraformPathArgument,varArg)
if stderr:
    raise Exception(stderr)
print( stdout )
