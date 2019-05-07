# Orchard Core Site Boilerplate

Site boilerplate is our starting point for building Orchard Core sites.

## Build Status

[![Build Status](https://secure.travis-ci.org/etchuk/Etch.OrchardCore.SiteBoilerplate.png?branch=master)](http://travis-ci.org/etchuk/Etch.OrchardCore.SiteBoilerplate) [![NuGet](https://img.shields.io/nuget/v/Etch.OrchardCore.SiteBoilerplate.svg)](https://www.nuget.org/packages/Etch.OrchardCore.SiteBoilerplate)

### Getting Started

To create a new site using the boilerplate it's quickest to use the dotnet new command. First you'll need to install the template, which is hosted on NuGet.

```
dotnet new -i Etch.OrchardCore.SiteBoilerplate
```

Once installed successfully, run the command below, which demonstrates all the possible parameters that are available.

```
dotnet new orchardcore-siteboilerplate -n Example.OrchardCore.Site -o Example.OrchardCore.Site -p "Your Site Name" -pd "Project description for your site"
```

### Parameters

Below are the different parameters that can be included in the dotnet new command. These parameters will be used in the .csproj and readme. -n & -o are parameters required by dotnet new.


#### -n/--name

Namespace and name of the .Net project e.g. Example.OrchardCore.Site

#### -o/--output

Location to place the generated output.

#### -p/--pname

Project name displayed in the read me.

#### -pd/--pdescription

Project description displayed in the read me.

## Packaging Template

This template has been made available on NuGet. To create the `.nupkg` file that can be published to NuGet, run the command shown below.

    nuget pack ./Etch.OrchardCore.SiteBoilerplate.nuspec

