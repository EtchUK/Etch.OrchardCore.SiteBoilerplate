# Orchard Core Site Boilerplate

Site boilerplate is our starting point for building Orchard Core sites.

## Build Status

[![NuGet](https://img.shields.io/nuget/v/Etch.OrchardCore.SiteBoilerplate.svg)](https://www.nuget.org/packages/Etch.OrchardCore.SiteBoilerplate)

## Orchard Core Reference

This template is referencing a stable build of Orchard Core ([`1.8.3`](https://www.nuget.org/packages/OrchardCore.Module.Targets/1.8.3)).

## Prerequisities

### [.NET Core](https://docs.microsoft.com/en-us/dotnet/core/)

Orchard Core runs on the .NET Core. Download the latest version from [https://www.microsoft.com/net/download/core](https://www.microsoft.com/net/download/core).

### Getting Started

To create a new site using the boilerplate it's quickest to use the dotnet new command. First you'll need to install the template, which is hosted on NuGet.

```
dotnet new -i Etch.OrchardCore.SiteBoilerplate --nuget-source https://api.nuget.org/v3/index.json
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
