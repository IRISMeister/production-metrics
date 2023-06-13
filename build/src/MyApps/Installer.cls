Class MyApps.Installer
{

XData setup [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Namespace Name="DUMMY1" Create="yes" Code="DUMMY1" Ensemble="1" Data="DUMMY1">
    <Configuration>
      <Database Name="DUMMY1" Dir="DUMMY1" Create="yes" Resource="%DB_DUMMY1"/>
    </Configuration>
    <CSPApplication Url="/csp/DUMMY1" Directory="${CSPDIR}DUMMY1" Resource=""/>
    <Import File="${SRCDIR}/Dummy/" Flags="ck" Recurse="true"/>
    <Production Name="Dummy.Production" AutoStart="1">
    </Production>
  </Namespace>
  <Namespace Name="DUMMY2" Create="yes" Code="DUMMY2" Ensemble="1" Data="DUMMY2">
    <Configuration>
      <Database Name="DUMMY2" Dir="DUMMY2" Create="yes" Resource="%DB_DUMMY2"/>
    </Configuration>
    <CSPApplication Url="/csp/DUMMY2" Directory="${CSPDIR}DUMMY2" Resource=""/>
    <Import File="${SRCDIR}/Dummy/" Flags="ck" Recurse="true"/>
    <Production Name="Dummy.Production" AutoStart="0">
    </Production>
  </Namespace>
  <Namespace Name="DUMMY3" Create="yes" Code="DUMMY3" Ensemble="1" Data="DUMMY3">
    <Configuration>
      <Database Name="DUMMY3" Dir="DUMMY3" Create="yes" Resource="%DB_DUMMY3"/>
    </Configuration>
    <CSPApplication Url="/csp/DUMMY3" Directory="${CSPDIR}DUMMY3" Resource=""/>
    <Import File="${SRCDIR}/Dummy/" Flags="ck" Recurse="true"/>
    <Production Name="Dummy.Production" AutoStart="0">
    </Production>
  </Namespace>
  <Namespace Name="emonitor" Create="yes" Code="emonitor" Ensemble="1" Data="emonitor">
    <Configuration>
      <Database Name="emonitor" Dir="emonitor" Create="yes" Resource="%DB_emonitor"/>
    </Configuration>
    <CSPApplication Url="/csp/emonitor" Directory="${CSPDIR}emonitor" Resource=""/>
    <Import File="${SRCDIR}/EM/" Flags="ck" Recurse="true"/>
    <Production Name="EM.Production" AutoStart="1">
    </Production>
  </Namespace>
</Manifest>
}

ClassMethod setupMethod(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

ClassMethod setup(ByRef tVars) As %Status
{
  Set tSC='$$$OK
  Try {
    If '$D(tVars("SRCDIR")) { Set tVars("SRCDIR")="/home/irisowner/src" }

    Set tSC=..setupMethod(.tVars)
    $$$ThrowOnError(tSC)

    Set oldns=$NAMESPACE
    New $NAMESPACE
    Set $NAMESPACE="%SYS"

    #; /csp/emonitorをAnalytics有効に。(Portlet使用のため)
    Set webapp="/csp/emonitor"
    Set tSC = ##Class(Security.Applications).Get(webapp,.props)
    Set props("DeepSeeEnabled")=1
    Set tSC = ##Class(Security.Applications).Modify(webapp,.props)

    Set $NAMESPACE="emonitor"
    Set tSC=##class(Ens.Config.Credentials).SetCredential("MONITOR","SuperUser","SYS",1)
    Set emcli=##class(Ens.Enterprise.MonitorClient).%New()
    Set emcli.Name="iris1"
    Set emcli.WebIPAddress="iris:52773"
    Set emcli.Namespace="DUMMY1"
    Set emcli.SOAPCredentials="MONITOR"
    Set tSC=emcli.%Save()

    Set emcli=##class(Ens.Enterprise.MonitorClient).%New()
    Set emcli.Name="iris2"
    Set emcli.WebIPAddress="iris:52773"
    Set emcli.Namespace="DUMMY2"
    Set emcli.SOAPCredentials="MONITOR"
    Set tSC=emcli.%Save()

    Set emcli=##class(Ens.Enterprise.MonitorClient).%New()
    Set emcli.Name="iris3"
    Set emcli.WebIPAddress="iris:52773"
    Set emcli.Namespace="DUMMY3"
    Set emcli.SOAPCredentials="MONITOR"
    Set tSC=emcli.%Save()

    Set $NAMESPACE="DUMMY1"
    do ##class(Ens.Util.Statistics).EnableSAMForNamespace()
    // The Ens.Util.Statistics class provides methods for customizing the output of the /metrics endpoint. 
    // For example, invoking the method DisableSAMIncludeHostLabel will provide aggregated metrics for the entire production instead of providing them 
    // for each host individually.
    Set tSC=##class(Ens.Util.Statistics).DisableSAMIncludeHostLabel()

    // EnableStatsForProduction() for detailed stats

    Set $NAMESPACE="DUMMY2"
    do ##class(Ens.Util.Statistics).EnableSAMForNamespace()
    Set tSC=##class(Ens.Util.Statistics).DisableSAMIncludeHostLabel()
    Set $NAMESPACE="DUMMY3"
    do ##class(Ens.Util.Statistics).EnableSAMForNamespace()
    Set tSC=##class(Ens.Util.Statistics).DisableSAMIncludeHostLabel()

    Set $NAMESPACE=oldns

  } Catch(e) {
	  Set tSC=e.AsStatus()
    zw tSC
  }
  Return tSC
}

}
