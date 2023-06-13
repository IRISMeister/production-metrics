Class Dummy.Service.Direct Extends Ens.BusinessService [ Language = objectscript ]
{

Property Value As %Integer;

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC=$$$OK
	Try {
		Set ..Value=..Value+1
		Set tSC=..SendRequestAsync("AdapterError",pInput)
		$$$ThrowOnError(tSC)
	}
	Catch e {
		Set tSC=e.AsStatus()
	}
	
	Return tSC
}

}
