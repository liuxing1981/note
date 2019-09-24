# RBAC

## Enable feature flag enableRoleBasedAccess
> HLR,HSS 同时控制，要同时改这2个才生效
```
dc=PGW 
dc=CONFIGURATION 
dc=APPLICATIONS
nodeName=HLR_SUBSCRIBER
nodeName=DEFAULT
nodeName=POD
dataType=featureFlagType
featureName=enableRoleBasedAccess
```

## HLR
```
# in LTE repo
development/provgw/webgui3gppHss/3gpphss/wm/config/WEB-INF/classes/hlrGuiPolicies.properties

# in HLR repo
HLR_AEP/cntdb/cntdb_development/cntdb/3gpphss_webgui/addon/hlraddon/wm/src/jsp/hlr/formatNSR.jsp
# modi html id. If you wannt show only use EXE
    <%if(isExtendedRpiEnabled){%>
                <%if ( PodDataReader.getUserPermissions( request, PodDataReader.PERMISSION_NSR | PodDataReader.PERMISSION_DISPLAY ) && PodDataReader.isPolicyEnabled(request, "HLR_NSR_CORRELATION_PLAN_EXE")){ %>
        <li id="HLR_NSR_CORRELATION_PLAN_EXE">
                <a target='mainFrame' href="#" onclick="buildFrameURL(common,'<%=INameConstants.CORRELATION_PLAN_DISPLAY_PAGE%>',initial,this);">
                        <%=correlationPlan%>
                </a>
                <%}%>
        </li>
    <%}%>
```