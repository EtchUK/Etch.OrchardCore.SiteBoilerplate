# Modules

Add modules that are specific to this project in this directory. Generic modues that could likely be reused on other projects should have their own Git repository and made available on NuGet (e.g. https://github.com/etchuk/Etch.OrchardCore.SEO).

## Creating new module

If you're creating a new module why not use the [module boilerplate project](https://github.com/etchuk/Etch.OrchardCore.ModuleBoilerplate) to do all the set up and allow you to get straight in to development.

### Installing module

Once the module has been added to the "Modules" directory, open the solution in Visual Studio, right click the "Modules" directory in Solution Explorer and add an existing project. Add the module as a dependency in the `Etch.OrchardCore.SiteBoilerplate` project, which will make the theme available within Orchard Core CMS.
