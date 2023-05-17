using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Etch.OrchardCore.SiteBoilerplate.Middleware
{
    public class MediaLibraryNoCacheMiddleware
    {
        private readonly RequestDelegate _next;

        public MediaLibraryNoCacheMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public Task Invoke(HttpContext httpContext)
        {
            var noCachePaths = new List<string>
            {
                "/Admin/Media/GetFolders",
                "/Admin/Media/GetMediaItems"
            };

            if (httpContext.Request.Path.HasValue && noCachePaths.Any(x => httpContext.Request.Path.Value.EndsWith(x, StringComparison.OrdinalIgnoreCase)))
            {
                httpContext.Response.Headers["cache-control"] = "no-cache";
            }

            return _next.Invoke(httpContext);
        }
    }
}
