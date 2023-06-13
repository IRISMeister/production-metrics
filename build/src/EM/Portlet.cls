Class EM.Portlet Extends %DeepSee.Component.Portlet.abstractPortlet
{

/// Static HTML display method: draw the BODY of this component as HTML.
Method %DrawHTML()
{
  &html<<div class="portletDiv" style="overflow:hidden;">>
  &html<<div style="font-size:16px; border-bottom:1px solid gray;">My Widget</div>>
 
  Set rs=##class(%ResultSet).%New("Ens.Enterprise.Portal.MonitorModel:getMatrix")
  Do rs.Execute()
  Set cnt=1
  While(rs.%Next()) {
      Set Color=rs.Get("Color")
      Set ERR=$P(Color,",",1)
      Set OK=$P(Color,",",5)
      Set QueueCount=rs.Get("QueueCount")
      Set Status=rs.Get("Status")
      Set ProductionName=rs.Get("ProductionName")
      Set WebIPAddress=rs.Get("WebIPAddress")
      Set HomePage=rs.Get("HomePage")
      Set HomePath=rs.Get("HomePath")
      Set Link="http://"_WebIPAddress_HomePath_"EnsPortal.ProductionMonitor.zen"
      Set ClientName=rs.Get("ClientName")
      Set tInfo(cnt) = $LB(ClientName,QueueCount,Status,ProductionName,Link,ERR)
      Set cnt=cnt+1
  }
  k rs
  /*
  Set tInfo(1) = $LB("売上","UP","12")
  Set tInfo(2) = $LB("Costs","DOWN","-8")
  Set tInfo(3) = $LB("Profits","UP","18")
  Set tInfo(4) = $LB("XXXX","UP","18")
  */

  &html<<table width="100%" cellspacing="0" border="0">>
  &html<
    <tr style="font-size:24px;">
    <th style="padding:4px;">クライアント名</th>
    <th style="padding:4px;">キュー</th>
    <th style="padding:4px;">ステータス</th>
    <th style="padding:4px;">プロダクション名</th>
    <th style="padding:4px;">モニタ画面</th>
    <th style="padding:4px;">エラー件数</th>
    </tr>
  >
  Set n = $O(tInfo(""))
  While (n'="") {
    Set tName = $LG(tInfo(n),1)
    Set tQue = $LG(tInfo(n),2)
    Set tStatus = $LG(tInfo(n),3)
    Set tProdName = $LG(tInfo(n),4)
    Set tLink = $LG(tInfo(n),5)
    Set tErr = $LG(tInfo(n),6)
    Set clr = $S(tErr>0:"red",1:"black")
    Set bg = $S(n#2:"#FFEEEE",1:"white")
    &html<<tr style="font-size:24px; background:#(bg)#;color:#(clr)#;">
      <td style="padding:4px;">#(tName)#</td>
      <td style="padding:4px;text-align:right;">#(tQue)#</td>
      <td style="padding:4px;">#(tStatus)#</td>
      <td style="padding:4px;">#(tProdName)#</td>
      <td style="padding:4px;"><a href=#(tLink)#>#(WebIPAddress)#</a></td>
      <td style="padding:4px;text-align:right;">#(tErr)#</td></tr>>
    Set n = $O(tInfo(n))
  }
  &html<</table>>
  &html<</div>>
}

}
