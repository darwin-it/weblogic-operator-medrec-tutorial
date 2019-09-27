#############################################################################
# Deploy MedRec application for WLS Advanced System Administration 
# course environment
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 0.1, 2013-11-27
#
#############################################################################
# Modify these values as necessary
import sys, traceback
adminUrl = 'localhost:7020'
serverName='AAServer1';

adminUser='weblogic';
adminPwd='welcome1';
target = serverName
appName = 'medrec'
appSource = '../ear/medrec.ear'

def main():
  try:
    # Connect to administration server
    connect(adminUser, adminPwd, adminUrl)
    # Deploy the application
    print 'Deploying application ' + appName + '.'
    progress = deploy(appName=appName,path=appSource,targets=target)
    # Wait for deploy to complete
    while progress.isRunning():
      pass
    print 'Application ' + appName + ' deployed.'
  except:
    apply(traceback.print_exception, sys.exc_info())
    exit(exitcode=1)

#call main()
main()
exit()
