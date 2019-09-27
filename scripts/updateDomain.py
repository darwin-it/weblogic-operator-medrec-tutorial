#############################################################################
# Create MedRecGlobalDataSourceXA for WLS Advanced System Administration 
# course environment
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 0.1, 2013-11-27
#
#############################################################################
# Modify these values as necessary
import sys, traceback, os
from weblogic.management.configuration import TargetMBean

domainHome = os.environ.get("DOMAIN_HOME")
dsName = 'MedRecGlobalDataSourceXA'
dsJNDIName = 'jdbc/MedRecGlobalDataSourceXA'
targetName = 'medrec-cluster'
#initialCapacity = 5
initialCapacity = 0
maxCapacity = 10
capacityIncrement = 1
driverName = 'oracle.jdbc.xa.client.OracleXADataSource'
driverURL = 'jdbc:oracle:thin:@localhost:1521:orcl'
databaseUsername = 'medrec'
databasePassword = 'welcome1'

def createDataSource(dsName, dsJNDIName, initialCapacity, maxCapacity, capacityIncrement, drvName, drvURL, dbUsername, dbPassword, target):
  #Check DataSource
  cd('/JDBCSystemResources/' )
  resources=ls()
  if resources.find(dsName)>-1:
    cd('/JDBCSystemResources/' + dsName)
    jdbcResource=cmo
    print 'The JDBC Data Source ' + dsName + ' already exists.'
  else:
    print 'Create DataSource ' + dsName + ' with JNDIName: '+dsJNDIName
    # Create a DataSource
    print 'Creating new JDBC Data Source named ' + dsName + '.'
    cd('/')
    # Create data source
    jdbcSystemResource = create(dsName, 'JDBCSystemResource')
    resource='/JDBCSystemResource/' + dsName + '/JdbcResource/' + dsName
    cd(resource)
    jdbcResource = cmo
    jdbcResource.setName(dsName)
    # Set JNDI name
    print '.. Create JDBCDataSourceParams'
    cd(resource)
    create('myJdbcDataSourceParams','JDBCDataSourceParams')
    cd('JDBCDataSourceParams/NO_NAME_0')
    set('JNDIName', java.lang.String(dsJNDIName))
    set('GlobalTransactionsProtocol', 'TwoPhaseCommit')
    # Create connection pool
    print '.. Create JDBCConnectionPoolParams'
    cd(resource)
    create('myJdbcConnectionPoolParams','JDBCConnectionPoolParams')
    cd('JDBCConnectionPoolParams/NO_NAME_0')    
    set('InitialCapacity', initialCapacity)
    set('MaxCapacity', maxCapacity)
    set('CapacityIncrement', capacityIncrement)
    # Create driver settings
    print '.. Create JDBCDriverParams'
    cd(resource)
    create('myJdbcDriverParams','JDBCDriverParams')
    cd('JDBCDriverParams/NO_NAME_0')
    set('DriverName', drvName)
    set('Url', drvURL)
    set('PasswordEncrypted', dbPassword)
    set('UseXADataSourceInterface', 'true')
    print '.. Create User Property'
    create('myProperties','Properties')
    cd('Properties/NO_NAME_0')
    create('user','Property')
    cd('Property/user')
    set('Value', dbUsername)  
    # Set data source target
    print '.. Assign '+dsName+ ' to '+target
    cd(resource)
    assign('JDBCSystemResource', dsName, 'Target', target)
    print 'Data Source created successfully.'
  return jdbcResource;
#
# Deploy Medrec application
def deployMedrec(): 
  cd("/")
  clusterName = "medrec-cluster"
  print 'Deploy Medrec Application to cluster '+clusterName
  cluster=get('/Clusters/'+clusterName)
  print 'Cluster name: '+cluster.name
  appDpl=create("MedRec", "AppDeployment")
  appDpl.setTargets(jarray.array([cluster],TargetMBean))
  appDpl.setModuleType("ear")
  appDpl.setSourcePath("wlsdeploy/applications/medrec.ear")
#
def main():
  try:
    print '\nRead Domain '+domainHome
    readDomain(domainHome)
    print '\nCreate Datasource '+dsName
    dataSource = createDataSource(dsName, dsJNDIName, initialCapacity, maxCapacity, capacityIncrement, driverName, driverURL,  databaseUsername, databasePassword,targetName);
    print '\nUpdate and close Domain '
    updateDomain()
    closeDomain()
  except:
    apply(traceback.print_exception, sys.exc_info())
    exit(exitcode=1)

#call main()
main()
#exit()
