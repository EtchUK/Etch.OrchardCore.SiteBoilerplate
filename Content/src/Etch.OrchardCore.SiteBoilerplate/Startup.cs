using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Etch.OrchardCore.SiteBoilerplate
{
    public class Startup
    {
        private readonly IHostEnvironment _env;

        public Startup(IHostEnvironment env)
        {
            _env = env;
        }

        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<FormOptions>(options => options.ValueCountLimit = 4096);

            var builder = services.AddOrchardCms();

            if (!_env.IsDevelopment())
            {
                builder.AddDatabaseShellsConfiguration();
            }
            else
            {
                builder.AddSetupFeatures("OrchardCore.AutoSetup");
            }

            services.Configure<ForwardedHeadersOptions>(options =>
            {
                options.ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedHost | ForwardedHeaders.XForwardedProto;
                options.KnownNetworks.Clear();
                options.KnownProxies.Clear();
            });

            services.AddAntiforgery(options =>
            {
                options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
            });

            services.Configure<CookieTempDataProviderOptions>(options => options.Cookie.SecurePolicy = CookieSecurePolicy.Always);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseForwardedHeaders();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseStaticFiles();
            app.UseOrchardCore();
            app.UsePoweredByOrchardCore(false);
        }
    }
}
