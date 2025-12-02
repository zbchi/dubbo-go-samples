# CORS 示例

本示例演示如何为 Dubbo-go Triple 协议服务配置 CORS（跨域资源共享）。

## 简介

CORS 允许运行在一个源上的 Web 应用程序访问来自另一个源的资源。本示例展示了如何在 Dubbo-go 中为 Triple 协议服务启用和配置 CORS。

## CORS 配置

服务器配置了以下 CORS 设置：

- **允许的源**: `http://example.com`, `https://*.sub.example.com`
- **允许的方法**: `POST`, `GET`, `OPTIONS`
- **允许的请求头**: `Content-Type`, `Authorization`
- **暴露的响应头**: `X-Custom-Header`
- **允许凭证**: `true`
- **最大缓存时间**: `3600` 秒（1 小时）

## 如何运行

### 1. 生成 Proto 文件

首先，生成 proto 文件：

```bash
cd cors/proto
protoc --go_out=. --go-triple_out=. greet.proto
```

### 2. 启动服务器

```bash
cd cors/go-server/cmd
go run main.go
```

服务器将在端口 `20000` 上启动，并启用 CORS。

### 3. 运行客户端

在另一个终端中：

```bash
cd cors/go-client/cmd
go run main.go
```

## CORS 配置详情

CORS 配置通过 `protocol.WithTriple()` 和 `triple.WithCORS()` 应用：

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

### 配置选项

- **CORSAllowOrigins**: 设置允许的源。支持通配符模式，如 `https://*.sub.example.com`。
- **CORSAllowMethods**: 设置允许的 HTTP 方法。
- **CORSAllowHeaders**: 设置允许的请求头。
- **CORSExposeHeaders**: 设置暴露给浏览器的响应头。
- **CORSAllowCredentials**: 切换是否允许凭证（cookies、授权头等）。
- **CORSMaxAge**: 设置预检请求缓存的最大时间（秒）。

## 测试 CORS

您可以使用 Web 浏览器或 `curl` 等工具测试 CORS：

```bash
# 预检请求 (OPTIONS)
curl -X OPTIONS http://127.0.0.1:20000/greet.GreetService/Greet \
  -H "Origin: http://example.com" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: Content-Type" \
  -v

# 实际请求
curl -X POST http://127.0.0.1:20000/greet.GreetService/Greet \
  -H "Origin: http://example.com" \
  -H "Content-Type: application/json" \
  -d '{"name":"World"}' \
  -v
```

## 注意事项

- 当 `CORSAllowCredentials` 设置为 `true` 时，`Access-Control-Allow-Origin` 头不能是 `*`（必须是特定源）。
- 服务器会验证 CORS 配置，并对无效配置记录错误日志。
- CORS 仅适用于 Triple 协议服务。







