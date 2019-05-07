# Themes

Add themes that are specific to this project in this directory. Generic themes that could likely be reused on other projects should have their own Git repository and made available on NuGet (e.g. https://github.com/etchuk/Etch.OrchardCore.EventsTheme).

## Creating new Theme

If you're creating a new theme why not use the [theme boilerplate project](https://github.com/etchuk/Etch.OrchardCore.ThemeBoilerplate) to do all the set up and allow you to focus on theming.

### Installing Theme

Once the theme has been added to the "Themes" directory, open the solution in Visual Studio, right click the "Themes" directory in Solution Explorer and add an existing project. Add the theme as a dependency in the `Etch.OrchardCore.SiteBoilerplate` project, which will make the theme available within Orchard Core CMS.
