using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;

namespace Etch.OrchardCore.SiteBoilerplate.Middleware
{
    public class SecurityHeadersMiddleware
    {
        private readonly RequestDelegate _next;

        public SecurityHeadersMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public Task Invoke(HttpContext httpContext)
        {
            httpContext.Response.Headers["Referrer-Policy"] = "strict-origin-when-cross-origin";
            httpContext.Response.Headers["X-Frame-Options"] = "DENY";
            httpContext.Response.Headers["X-XSS-Protection"] = "1; mode=block";
            httpContext.Response.Headers["X-Content-Type-Options"] = "nosniff";
            return _next.Invoke(httpContext);
        }
    }
}
