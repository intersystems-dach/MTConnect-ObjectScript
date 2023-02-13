<img src = "https://raw.githubusercontent.com/phil1436/MTConnect-ObjectScript/master/resources/logo.png" alt = "Logo" width = "50%"/>

# MTConnect-ObjectScript

An [InterSystems ObjectScript](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GCOS_INTRO) implementation, thats builds an ObjectScript Class based on a [MTConnect](https://www.mtconnect.org/) probe file and adds data from a current file.

---

-   [Installation](https://github.com/phil1436/MTConnect-ObjectScript#installation)
-   [MTConnect.MSG.MTConnectRequest / Response](https://github.com/phil1436/MTConnect-ObjectScript#mtconnectmsgmtconnectrequest--response)
-   [MTConnect.BO.ClassBuilder](https://github.com/phil1436/MTConnect-ObjectScript#mtconnectboclassbuilder)
-   [MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript#mtconnectmsgcreatedatatyperequest)
-   [MTConnect.DataTypesBuilder](https://github.com/phil1436/MTConnect-ObjectScript#mtconnectdatatypesbuilder)
-   [MTConnect.BO.DataTypesBuilderOperation](https://github.com/phil1436/MTConnect-ObjectScript#mtconnectbodatatypesbuilderoperation)
-   [Example Production](https://github.com/phil1436/MTConnect-ObjectScript#example-production)
    -   [DataTypes](https://github.com/phil1436/MTConnect-ObjectScript#datatypes)
    -   [Class Builder](https://github.com/phil1436/MTConnect-ObjectScript#class-builder)
-   [Bugs](https://github.com/phil1436/MTConnect-ObjectScript#bugs)
-   [Release Notes](https://github.com/phil1436/MTConnect-ObjectScript#release-notes)

---

## Installation

-   Download the [latest realease](https://github.com/phil1436/MTConnect-ObjectScript/releases/latest)
-   Extract the file
-   In the [InterSystems Management Portal](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GSA_USING_PORTAL) navigate to `System Explorer > Classes`
-   Click on `Import`
-   Under _Import from File or a Directory_ make sure to select _Directory_
-   Enter the path to the [MTConnect Folder](https://github.com/phil1436/MTConnect-ObjectScript/tree/master/src/cls/MTConnect) under `src/cls/MTConnect`
-   Click on `Import`

<img src="https://raw.githubusercontent.com/phil1436/MTConnect-ObjectScript/master/resources/ImportClassesScreenshot.png" title ="ImportClassesScreenshot" width = "60%"/>

### Installation via InterSystems Package Manager

-   Make sure you have the [InterSystems Package Manager](https://github.com/intersystems/ipm) installed.
-   Then run the following command in the InterSystems terminal:

```bash
zpm "install mtconnect-objectscript"
```

---

## [MTConnect.MSG.MTConnectRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/MTConnectRequest.cls) / [Response](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/MTConnectResponse.cls)

-   `probe`: Holds the data from the probe file.
-   `probeFromFile`: When enabled the probe property contains an absolute path to the probe file. When disabled the probe property contains the probe file as a string.
-   `current`: Holds the data from the current file.
-   `currentToFile`: When enabled the current property contains an absolute path to the current file. When disabled the current property contains the current file as a string.
-   `recievedLine`(optional): Holds a received string. (Used for _cleardata_)
-   `className`(will be set): The complete class name of the generated class.

---

## [MTConnect.BO.ClassBuilder](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/BO/ClassBuilder.cls)

A Business Operation, that builts an ObjectScript class based on a MTConnect probe file. After the class is successfully generated, the operation inserts data from a MTConnect current file.

### Request

[MTConnect.MSG.MTConnectRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/MTConnectRequest.cls)

### Response

[MTConnect.MSG.MTConnectResponse](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/MTConnectResponse.cls)

### Settings

#### MTConnect

-   `PackageName`: The package where the class will be generated in.
-   `suffixClass`: A suffix for the class name.
-   `Kind`: _ID_ or _Name_. Sets from which attributes the class will be build.
-   `ClearData`: When enabled deletes all data, when a `***CL***` message is received.
-   `SuperClasses`: Define comma seperated superclasses for the class.

#### MTConnectDataTypes

-   `GenerateDataTypes`: When enabled the MTConnect Datatypes will be generated automatically.
-   `DataTypesPackage`: The package where the MTConnect datatypes exists or will be generated in.
-   `GenerateIsValid`: When enabled generates a IsValid Method for the datatypes
-   `GenerateNormalize`: When enabled generates a Normalize Method for the datatypes
-   `GenerateLogicalToDisplay`: When enabled generates a LogicalToDisplay Method for the datatypes
-   `GenerateDisplayToLogical`: When enabled generates a DisplayToLogical Method for the datatypes

#### LOG

-   `Log`: When enabled all changes will be written to a log file.
-   `LogFile`: An absolute path to the log file.

---

## [MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/CreateDataTypeRequest.cls)

-   `Name`: The name of the datatype.
-   `Unit`: The unit to display the datatype with.
-   `DataType`: The underlying ObjectScript type (Currently only works with _%String_, _%Integer_ and _%Double_).
-   `AllowedStringValues`: Comma separated list for the allowed values. If left empty all values will be allowed. (only used when `DataType` is _%String_)
-   `AllowedNumericMaxValue`: The maximum value that is allowed. If left empty all values will be allowed. (only used when `DataType` is _%Double_ or _%Integer_)
-   `AllowedNumericMinValue`: The minimum value that is allowed. If left empty all values will be allowed. (only used when `DataType` is _%Double_ or _%Integer_)

---

## [MTConnect.DataTypesBuilder](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/DataTypesBuilder.cls)

Builds MTConnect Datatypes based on a [MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/cls/MTConnect/MSG/CreateDataTypeRequest.cls).

### Execute Method

-   `pRequest`: The [MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/CreateDataTypeRequest.cls)
-   `pPackage`: The package name to store the datatypes (Default is _MTConnect.DataTypes_)
-   `pGenerateIsValid`: If enabled generates the _IsValid_ method for the datatype (enabled by default)
-   `pGenerateNormalize`: If enabled generates the _Normalize_ method for the datatype (enabled by default)
-   `pGenerateDisplayToLogical`: If enabled generates the _DisplayToLogical_ method for the datatype (enabled by default)
-   `pGenerateLogicalToDisplay`: If enabled generates the _LogicalToDisplay_ method for the datatype (enabled by default)

---

## [MTConnect.BO.DataTypesBuilderOperation](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/BO/DataTypesBuilderOperation.cls)

A Business Operation to build MTConnect Datatypes based on a [MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/CreateDataTypeRequest.cls).

### Request

[MTConnect.MSG.CreateDataTypeRequest](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/MSG/CreateDataTypeRequest.cls)

### Response

[Ens.StringResponse](https://docs.intersystems.com/irislatest/csp/documatic/%25CSP.Documatic.cls?LIBRARY=ENSLIB&CLASSNAME=Ens.StringResponse)

### Settings

#### DataType

-   `Package`: The package name to store the datatypes (Default is _MTConnect.DataTypes_)
-   `IsValid`: If enabled generates the _IsValid_ method for the datatype
-   `Normalize`: If enabled generates the _Normalize_ method for the datatype
-   `DisplayToLogical`: If enabled generates the _DisplayToLogical_ method for the datatype
-   `LogicalToDisplay`: If enabled generates the _LogicalToDisplay_ method for the datatype

> Tip: Hava a look at [MTConnect.DataTypes](https://github.com/phil1436/MTConnect-ObjectScript/tree/master/src/cls/MTConnect/DataTypes) for some default MTConnect DataTypes.

---

## [Example Production](https://github.com/phil1436/MTConnect-ObjectScript/tree/master/src/cls/MTConnect/ExampleProduction)

A simple [Production](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/ExampleProduction/Production.cls) to show the usage of the [DataTypesBuilder Operation](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/BO/DataTypesBuilderOperation.cls) and the [ClassBuilder Operation](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/BO/ClassBuilder.cls).

How to open and start the Production:

-   In the InterSystems Management Portal navigate to `Interoperabilty > Configure > Production > Go`
-   Click on `Production Settings`
-   Navigate to `Actions > Open`
-   Choose `MTConnect > ExampleProduction > Production > Go`
-   Click on `Start`

### DataTypes

An example for how to use the [DataTypesBuilder Operation](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/BO/DataTypesBuilderOperation.cls) to create MTConnect DataTypes.

-   From the _category_ dropdown menu choose `DataTypes`
-   Choose the `DataTypes Process`
-   Navigate to `Actions > Test`
-   From the _Request Type_ dropdown menu choose `Ens.StringRequest`
    -   Type in the `StringValue` field _String_ to generate a String MTConnect DataType
        **OR**
    -   Type in the `StringValue` field _Double_ to generate a Double MTConnect DataType
        **OR**
    -   Type in the `StringValue` field _Inetger_ to generate a Integer MTConnect DataType
-   Click on `Invoke Testing Service`
-   You can follow the _Visual Trace_ to see how the DataType was created
-   You will find the DataTypes under `MTConnect.ExampleProduction.DataTypes`

![resources/ExampleProductionDataTypesDemo](https://raw.githubusercontent.com/phil1436/MTConnect-ObjectScript/master/resources/ExampleProductionDataTypesDemo.gif)

### Class Builder

An example for how to use the [ClassBuilder Operation](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/src/cls/MTConnect/BO/ClassBuilder.cls) to create MTConnect Class from a MTConnect [Probe](http://mtconnect.mazakcorp.com:5609/probe) and [Current](http://mtconnect.mazakcorp.com:5609/current) file.

-   From the _category_ dropdown menu choose `Class Builder`
-   Choose the `Class Builder Process`
-   Navigate to `Actions > Test`
-   From the _Request Type_ dropdown menu choose `Ens.Request`
-   Click on `Invoke Testing Service`
-   You can follow the _Visual Trace_ to see how the MTConnect Class was created
-   You will find the MTConnect Class under `MTConnect.ExampleProduction.BuiltClasses`
-   The Operation will also generate MTConnect DataTypes based on the files. You can find them under `MTConnect.ExampleProduction.DataTypes`

![resources/ExampleProductionClassBuilderDemo](https://raw.githubusercontent.com/phil1436/MTConnect-ObjectScript/master/resources/ExampleProductionClassBuilderDemo.gif)

---

## Bugs

-   _no known bugs_

---

## [Release Notes](https://github.com/phil1436/MTConnect-ObjectScript/blob/master/CHANGELOG.md)

### [v0.0.4](https://github.com/phil1436/MTConnect-ObjectScript/tree/0.0.4)

---

View on [InterSystems Open Exchange](https://openexchange.intersystems.com/package/MTConnect-ObjectScript).
View the related article on [InterSystems Developer Community](https://community.intersystems.com/post/mtconnect-objectscript-implementation).

---

by Jannis S. & Philipp B.

<!--powered by [InterSystems](https://www.intersystems.com/).

_This application is **not** supported by InterSystems Corporation._-->
