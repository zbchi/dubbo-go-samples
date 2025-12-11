# CORS Sample

This sample demonstrates how to configure CORS (Cross-Origin Resource Sharing) for Dubbo-go Triple protocol services.

## Introduction

CORS allows web applications running at one origin to access resources from another origin. This sample shows how to enable and configure CORS for Triple protocol services in Dubbo-go.

## CORS Configuration

The server is configured with the following CORS settings:

- **Allowed Origins**: `http://example.com`, `https://*.sub.example.com`
- **Allowed Methods**: `POST`, `GET`, `OPTIONS`
- **Allowed Headers**: `Content-Type`, `Authorization`
- **Exposed Headers**: `X-Custom-Header`
- **Allow Credentials**: `true`
- **Max Age**: `3600` seconds (1 hour)

## How to Run

### Start the Server

```bash
go run go-server/cmd/main.go
```

The server will start on port `20000` with CORS enabled.

## CORS Configuration Details

The CORS configuration is applied using `protocol.WithTriple()` with `triple.WithCORS()`:

```go
protocol.WithTriple(
    triple.WithCORS(
        triple.CORSAllowOrigins("http://example.com", "https://*.sub.example.com"),
        triple.CORSAllowMethods("POST", "GET", "OPTIONS"),
        triple.CORSAllowHeaders("Content-Type", "Authorization"),
        triple.CORSExposeHeaders("X-Custom-Header"),
        triple.CORSAllowCredentials(true),
        triple.CORSMaxAge(3600),
    ),
)
```

### Configuration Options

- **CORSAllowOrigins**: Sets allowed origins for CORS requests. Supports wildcard patterns like `https://*.sub.example.com`.
- **CORSAllowMethods**: Sets allowed HTTP methods for CORS requests.
- **CORSAllowHeaders**: Sets allowed request headers for CORS requests.
- **CORSExposeHeaders**: Sets headers that are exposed to the browser.
- **CORSAllowCredentials**: Toggles whether credentials (cookies, authorization headers) are allowed.
- **CORSMaxAge**: Sets the max age (in seconds) for preflight cache.

## Testing CORS

You can test CORS using a web browser or tools like `curl`:

```bash
# Preflight request (OPTIONS)
curl -X OPTIONS http://127.0.0.1:20000/greet.GreetService/Greet \
  -H "Origin: http://example.com" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: Content-Type" \
  -v

# Actual request
curl -X POST http://127.0.0.1:20000/greet.GreetService/Greet \
  -H "Origin: http://example.com" \
  -H "Content-Type: application/json" \
  -d '{"name":"World"}' \
  -v
```

## Notes

- When `CORSAllowCredentials` is set to `true`, the `Access-Control-Allow-Origin` header cannot be `*` (must be a specific origin).
- The server validates CORS configuration and logs errors for invalid configurations.
- CORS only applies to Triple protocol services.







