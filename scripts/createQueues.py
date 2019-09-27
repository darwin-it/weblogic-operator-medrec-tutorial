#############################################################################
# Create Queues for WLS Advanced System Administration 
# course environment
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 0.1, 2013-05-21
#
#############################################################################
# Modify these values as necessary
import sys, traceback
adminUrl = 'localhost:7020'
serverName='AAServer1';

adminUser='weblogic';
adminPwd='welcome1';
target = serverName


domainHome='/app/work/domains/AADomain'
jmsFileStoreName='MedRecJMSFileStore'
jmsFileStoreDir=domainHome+'/'+jmsFileStoreName
#
jmsServerName = 'MedRecJMSServer'
subDeploymentName = 'DeployTo' + jmsServerName
jmsModuleName = 'MedRec-jms'
#
medRecJmsJNDIPrefix='com.oracle.medrec.jms.'
recordToCreateQueueName = 'RecordToCreateQueue'
recordToCreateQueueJNDIName = medRecJmsJNDIPrefix+recordToCreateQueueName
patientNotificationQueueName = 'PatientNotificationQueue'
patientNotificationQueueJNDIName = medRecJmsJNDIPrefix+patientNotificationQueueName
defaultQueueName = 'DefaultQueue'
defaultQueueJNDIName = 'weblogic.wsee.DefaultQueue'


#
def ensure_dir(dirPath):
    print 'Check directory path: '+dirPath
    d = os.path.dirname(dirPath)
    if not os.path.exists(d):
        print 'Directory does not exists so create.'
        os.makedirs(d)
    else:
        print 'Directory already exists.'
#     
def createFileStore(fileStoreDir, fileStoreName, targetServerName):
  #Check Filestore
  try:
          fileStoreMB='/FileStores/'+fileStoreName
          print 'Check filestore Managed Bean  '+ fileStoreMB
          cd(fileStoreMB)
          fileStore=cmo
          print 'The FileStore ' + fileStoreName + ' already exists.'
  except WLSTException:
          print 'Create FileStore ' + fileStoreName + ' with directory: '+fileStoreDir
          # create a filestore
          edit()
          startEdit()
          cd('/')
          fileStore=cmo.createFileStore(fileStoreName)
          fileStore.setDirectory(fileStoreDir)
          print "Add target: "+targetServerName
          targetServer=getMBean("/Servers/"+targetServerName)
          fileStore.addTarget(targetServer)
          # Activate changes
          save()
          activate(block='true')
          print 'Filestore '+fileStoreName+' created  successfully.'
  return fileStore;
#
def createJmsServer(jmsServerName, fileStore, targetServerName):
  try:
          jmsServerMB='/Deployments/'+jmsServerName
          print 'Check Jms Server Managed Bean  '+ jmsServerMB
          cd(jmsServerMB)
          jmsServer=cmo
          print 'The JMS Server ' + jmsServerName + ' already exists.'
  except WLSTException:
          print 'Create JMS Server' + jmsServerName
          # create JMS Server
          edit()
          startEdit()
          cd('/')
          jmsServer=cmo.createJMSServer(jmsServerName)
          print "Set persistentStore: "+fileStore.getName()
          jmsServer.setPersistentStore(fileStore)
          print "Add target: "+targetServerName
          targetServer=getMBean("/Servers/"+targetServerName)
          jmsServer.addTarget(targetServer)
          # Activate changes
          save()
          activate(block='true')
          print 'JMS Server '+jmsServerName+' created  successfully.'
  return jmsServer
#
def createJmsModule(jmsModuleName, targetJmsServer, targetServerName, subDeploymentName):
  # Check if JMS Module exists
  try:
          jmsModuleMB='/JMSSystemResources/' + jmsModuleName
          print 'Check Jms Module Managed Bean  '+ jmsModuleMB
          cd(jmsModuleMB)
          jmsModule = cmo
          print 'The JMS Module ' + jmsModuleName + ' already exists.'
  except WLSTException:
          print 'Create JMS Module ' + jmsModuleName 
          # create a JMS Module
          edit()
          startEdit()
          jmsModule = create(jmsModuleName, "JMSSystemResource")
          print "Add target: "+targetServerName
          targetServer=getMBean("/Servers/"+targetServerName)
          jmsModule.addTarget(targetServer)
          subDeployment = jmsModule.createSubDeployment(subDeploymentName)
          subDeployment.addTarget(targetJmsServer)
          # Activate changes
          save()
          activate(block='true')
          print 'JMS Module '+jmsModuleName+' created  successfully.'
  return jmsModule
#
def createQueue(queueName, queueJNDIName, jmsModuleName, subDeploymentName):
  # Check if Queue already exists
  try:
          jmsQueueMB='/JMSSystemResources/' + jmsModuleName + '/JMSResource/' + jmsModuleName + '/Queues/' + queueName
          print 'Check Jms Queue Managed Bean  '+ jmsQueueMB
          cd(jmsQueueMB)
          queue=cmo
          print 'The JMS Queue ' + queueName + ' already exists.' 
  except WLSTException:
          print 'Updating JMS Module named ' + jmsModuleName + ' to add queue '+queueName+'.'
          edit()
          startEdit()
          cd('/')
          # Create Queue
          print 'Creating new Queue named ' + queueName + '.'
          jmsResource = getMBean('/JMSSystemResources/' + jmsModuleName + '/JMSResource/' + jmsModuleName)
          queue = jmsResource.createQueue(queueName)
          queue.setJNDIName(queueJNDIName)
          queue.setSubDeploymentName(subDeploymentName)
          # Activate changes
          save() 
          activate(block='true')
          print 'JMS Module updated '+jmsModuleName+' successfully, with added queue '+queueName+'.'
  return queue
#
def main():
  try:
    # Create filstoreDirectory if it does not already exists.
    print 'Create FilestoreDirectory if it does not already exists.'
    ensure_dir(jmsFileStoreDir)
    #
    #Connect to administration server
    connect(adminUser, adminPwd, adminUrl)
    #
    print '\nCreate Filestore for '+target
    fileStore=createFileStore(jmsFileStoreDir, jmsFileStoreName, target)
    #
    print '\nCreate JMSServer for '+target
    jmsServer=createJmsServer(jmsServerName, fileStore, target)
    #
    print '\nCreate JMSModule for '+target
    jmsModule=createJmsModule(jmsModuleName, jmsServer, target, subDeploymentName )
    #
    print '\nCreate Queue: '+recordToCreateQueueName+' in module '+jmsModuleName+'.'
    jmsQueue=createQueue(recordToCreateQueueName, recordToCreateQueueJNDIName, jmsModuleName, subDeploymentName)
    # 
    print '\nCreate Queue: '+patientNotificationQueueName+' in module '+jmsModuleName+'.'
    jmsQueue=createQueue(patientNotificationQueueName, patientNotificationQueueJNDIName, jmsModuleName, subDeploymentName)
    #
    print '\nCreate Queue: '+defaultQueueName+' in module '+jmsModuleName+'.'
    jmsQueue=createQueue(defaultQueueName, defaultQueueJNDIName, jmsModuleName, subDeploymentName)
  except:
    apply(traceback.print_exception, sys.exc_info())
    exit(exitcode=1)

#call main()
main()
exit()
