# Dubbo-Go OpenTelemetry 链路追踪示例

[English](README.md) | 中文

本示例演示了如何在 Dubbo-Go 应用中使用 **OpenTelemetry** 进行分布式链路追踪。链路追踪功能帮助您通过跟踪跨多个服务的请求来监控和调试分布式系统。

-----

## 概述

OpenTelemetry 是一个供应商中立的可观测性框架，提供 API、SDK 和工具来收集、处理和导出遥测数据（追踪、指标和日志）。本示例专注于**链路追踪**，它允许您：

- 跟踪请求在分布式系统中的流转
- 识别性能瓶颈
- 通过跟踪请求路径来调试问题
- 理解服务依赖关系

## 包含的示例

本目录包含三个链路追踪导出器示例：

| 示例 | 描述 | 使用场景 |
| :--- | :--- | :--- |
| **stdout** | 将追踪数据输出到标准输出（控制台） | 开发和调试 |
| **jaeger** | 将追踪数据导出到 Jaeger 后端 | 使用 Jaeger UI 进行生产环境追踪 |
| **otlp_http_exporter** | 通过 OTLP HTTP 协议导出追踪数据 | 与任何 OTLP 兼容的后端集成 |

### stdout

最简单的链路追踪示例，直接将追踪数据输出到控制台。适用于：
- 快速开发测试
- 理解追踪数据结构
- 无需外部依赖的调试

**参见**: [stdout/README.md](stdout/README.md)

### jaeger

将追踪数据导出到 Jaeger，一个流行的分布式追踪系统。包括：
- 完整的 Jaeger UI 集成
- 追踪可视化和分析
- 服务依赖关系图

**参见**: [jaeger/README.md](jaeger/README.md)

### otlp_http_exporter

使用 OpenTelemetry 协议（OTLP）通过 HTTP 导出追踪数据。兼容：
- 任何 OTLP 兼容的后端（Jaeger、Zipkin、Tempo 等）
- OpenTelemetry Collector
- 云可观测性平台

**参见**: [otlp_http_exporter/README.md](otlp_http_exporter/README.md)

## 快速开始

### 前置条件

- Go 1.19 或更高版本
- Zookeeper（默认：`127.0.0.1:2181`）
- Jaeger 示例：Docker（用于运行 Jaeger 实例）

### 选择示例

根据您的需求选择其中一个示例：

1. **快速测试**：使用 `stdout` - 无需外部依赖
2. **可视化**：使用 `jaeger` - 需要 Jaeger 实例
3. **生产环境**：使用 `otlp_http_exporter` - 兼容各种后端

### 运行示例

每个示例都遵循类似的模式：

1. **启动服务端**：
   ```bash
   cd <示例目录>
   go run ./go-server/cmd/main.go
   ```

2. **启动客户端**（在新终端中）：
   ```bash
   cd <示例目录>
   go run ./go-client/cmd/main.go
   ```

3. **查看追踪数据**：
   - **stdout**：查看服务端控制台输出
   - **jaeger**：在浏览器中打开 `http://localhost:16686`
   - **otlp_http_exporter**：检查您配置的后端

详细说明请参考每个示例的 README 文件。

## 配置说明

Dubbo-Go 链路追踪使用 `trace` 包选项进行配置。常见配置包括：

### 基本配置

```go
import (
    "dubbo.apache.org/dubbo-go/v3/trace"
)

// 配置追踪导出器
trace.WithStdoutExporter()        // stdout 导出器
trace.WithJaegerExporter()        // Jaeger 导出器
trace.WithOtlpHttpExporter(...)   // OTLP HTTP 导出器
```