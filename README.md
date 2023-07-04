# production-metrics
WIP

Enterprize Monitorの内容をPortlet表示する例。

Sample dashboard based on tables emitted by Enterprize Monitor
```
http://localhost:52773/csp/emonitor/_DeepSee.UserPortal.DashboardViewer.zen?DASHBOARD=mydb.dashboard
```


Metrics for Productions
(Need DP-423470)

```
curl http://localhost:52773/api/monitor/metrics -s | grep inter
```
