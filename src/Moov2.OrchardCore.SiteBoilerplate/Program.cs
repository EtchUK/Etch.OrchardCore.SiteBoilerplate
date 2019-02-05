﻿using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using OrchardCore.Logging;

namespace Moov2.OrchardCore.SiteBoilerplate {
    public class Program {
        public static void Main(string[] args) {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseNLogWeb()
                .UseStartup<Startup>();
    }
}
