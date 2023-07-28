# Kong plugin: lets you send request and response logs to an HTTP server through a proxy

The `http-log-proxy` plugin extends the capacity of [HTTP Log plugin](https://docs.konghq.com/hub/kong-inc/http-log/) by providing the proxy tunneling.

The proxy parameters are:
- `http_proxy`: an URI to a proxy server to be used with HTTP requests
- `http_proxy_authorization`: a default Proxy-Authorization header value to be used with http_proxy, e.g. Basic ZGVtbzp0ZXN0, which will be overriden if the Proxy-Authorization request header is present.
- `https_proxy`: an URI to a proxy server to be used with HTTPS requests
- `https_proxy_authorization`: as http_proxy_authorization but for use with https_proxy (since with HTTPS the authorisation is done when connecting, this one cannot be overridden by passing the Proxy-Authorization request header).
- `no_proxy`: a comma separated list of hosts that should not be proxied.
