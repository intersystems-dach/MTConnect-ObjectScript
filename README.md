# MTConnect-ObjectScript

An [InterSystems ObjectScript](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GCOS_INTRO) implementation, thats builds an ObjectScript Class based on a [MTConnect](https://www.mtconnect.org/) probe file and adds data from a current file.

---

* [MTConnect.MSG.MTConnectRequest / Response](#mtconnectmsgmtconnectrequest--response)
* [MTConnect.BO.ClassBuilder](#mtconnectboclassbuilder)
  * [Request](#request)
  * [Response](#response)
  * [Settings](#settings)
* [MTConnect.MSG.CreateDataTypeRequest](#mtconnectmsgcreatedatatyperequest)
* [MTConnect.DataTypesBuilder / Operation](#mtconnectdatatypesbuilder--operation)
* [Bugs](#bugs)
* [Release Notes](#release-notes)

---

## [MTConnect.MSG.MTConnectRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/MSG/MTConnectRequest.cls) / [Response](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/MSG/MTConnectResponse.cls)

* `probe`: Holds the data from the probe file.
* `probeFromFile`: When enabled the probe property contains an absolute path to the probe file. When disabled the probe property contains the probe file as a string.
* `current`: Holds the data from the current file.
* `currentToFile`: When enabled the current property contains an absolute path to the current file. When disabled the current property contains the current file as a string.
* `recievedLine`(optional): Holds a received string. (Used for *cleardata*)
* `className`(will be set): The complete class name of the generated class.
* `logClass`(will be set): The complete class name of the log class(will not be used!).

---

## [MTConnect.BO.ClassBuilder](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/BO/ClassBuilder.cls)

A Business Operation, that builts an ObjectScript class based on a MTConnect probe file. After the class is successfully generated, the operation inserts data from a MTConnect current file.

### Request

[MTConnect.MSG.MTConnectRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/MSG/MTConnectRequest.cls)

### Response

[MTConnect.MSG.MTConnectResponse](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/MSG/MTConnectResponse.cls)

### Settings

#### MTConnect

* `PackageName`: The package where the class will be generated in.
* `suffixClass`: A suffix for the class name.
* `Kind`: *ID* or *Name*. Sets from which attributes the class will be build.
* `ClearData`: When enabled deletes all data, when a `***CL***` message is received.
* `SuperClasses`: Define comma seperated superclasses for the class.

#### MTConnectDataTypes

* `GenerateDataTypes`: When enabled the MTConnect Datatypes will be generated automatically.
* `DataTypesPackage`: The package where the MTConnect datatypes exists or will be generated in.
* `GenerateIsValid`: When enabled generates a IsValid Method for the datatypes
* `GenerateNormalize`: When enabled generates a Normalize Method for the datatypes
* `GenerateLogicalToDisplay`: When enabled generates a LogicalToDisplay Method for the datatypes
* `GenerateDisplayToLogical`: When enabled generates a DisplayToLogical Method for the datatypes

#### LOG

* `Log`: When enabled all changes will be written to a log file.
* `LogFile`: An absolute path to the log file.

---

## [MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/MSG/CreateDataTypeRequest.cls)

* `Name`: The name of the datatype.
* `Unit`: The unit to display the datatype with.
* `DataType`: The underlying ObjectScript type (Currently only works with *%String* and *%Double*).
* `AllowedStringValues`: Comma separated list for the allowed values. If left empty all values will be allowed. (only used when `DataType` is *%String*)
* `AllowedNumericMaxValue`: The maximum value that is allowed. If left empty all values will be allowed. (only used when `DataType` is *%Double*)
* `AllowedNumericMinValue`: The minimum value that is allowed. If left empty all values will be allowed. (only used when `DataType` is *%Double*)

---

## [MTConnect.DataTypesBuilder](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/DataTypesBuilder.cls) / [Operation](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/BO/DataTypesBuilderOperation.cls)

Builds MTConnect Datatypes based on a [MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/MTConnect/MSG/CreateDataTypeRequest.cls).

### Methods

* `Execute`: Builds the datatype.

---

## Bugs

* *no known bugs*

---

## [Release Notes](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/CHANGELOG.md)

## [v0.0.1](https://github.com/phil1436/MTConnect-ObjectScript/tree/0.0.1)

* *Initial release*

---

by Philipp B.

powered by [InterSystems](https://www.intersystems.com/).

*This application is **not** supported by InterSystems Corporation.*
