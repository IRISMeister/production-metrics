#!/bin/bash

docker compose up -d
echo "SMP | http://localhost:52873/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=MONITOR&"
