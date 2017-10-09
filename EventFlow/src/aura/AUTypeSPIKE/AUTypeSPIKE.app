<aura:application controller="clsStaticResCtrl" extends="force:slds">
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <br/>
    <br/>
    <br/>
    <div align="center">
        <table>
            <tr>
                <td width="23%"><div align="right">AU Type Template </div></td>
                <td width="2%" ></td>
                <td width="55%"><ui:inputTextArea aura:id="auType" rows="10" cols="150" /></td>
                <td width="20%" ></td>
            </tr>
        </table>
    </div>	
    <br/>
    <div align="center">
        <table>
            <tr>
                <td width="23%"></td>
                <td width="2%"></td>
                <td width="55%" ><div align="right"><ui:button label="Save Changes" press="{!c.updateChanges}"/></div></td>
                <td width="20%" ></td>
            </tr>
        </table>                
    </div>	    	
</aura:application>