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
  try:
    #Check DataSource
    cd('/JDBCSystemResources/' + dsName)
    jdbcResource=cmo
    print 'The JDBC Data Source ' + dsName + ' already exists.'
  except WLSTException:
    print 'Create DataSource ' + dsName + ' with JNDIName: '+dsJNDIName
    # Create a DataSource
    edit()
    startEdit()
    print 'Creating new JDBC Data Source named ' + dsName + '.'
    cd('/')
    # Save reference to target server
    targetServer = getMBean('/Servers/' + targetName)
    # Create data source
    jdbcSystemResource = create(dsName, 'JDBCSystemResource')
    jdbcResource = jdbcSystemResource.getJDBCResource()
    jdbcResource.setName(dsName)
    # Set JNDI name
    jdbcResourceParameters = jdbcResource.getJDBCDataSourceParams()
    jdbcResourceParameters.setJNDINames([dsJNDIName])
    jdbcResourceParameters.setGlobalTransactionsProtocol('TwoPhaseCommit')
    # Create connection pool
    connectionPool = jdbcResource.getJDBCConnectionPoolParams()
    connectionPool.setInitialCapacity(initialCapacity)
    connectionPool.setMaxCapacity(maxCapacity)
    connectionPool.setCapacityIncrement(capacityIncrement)
    # Create driver settings
    driver = jdbcResource.getJDBCDriverParams()
    driver.setDriverName(drvName)
    driver.setUrl(drvURL)
    driver.setPassword(dbPassword)
    driverProperties = driver.getProperties()
    userProperty = driverProperties.createProperty('user')
    userProperty.setValue(dbUsername)  
    # Set data source target
    jdbcSystemResource.addTarget(target)
    # Activate changes
    save()
    activate(block='true')
    print 'Data Source created successfully.'
  return jdbcResource;
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
exit()
