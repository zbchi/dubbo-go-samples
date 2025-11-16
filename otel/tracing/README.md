# Dubbo-Go OpenTelemetry Tracing Example

English | [中文](README_zh.md)

This example demonstrates how to use **OpenTelemetry** for distributed tracing in Dubbo-Go applications. The tracing feature helps you monitor and debug distributed systems by tracking requests across multiple services.

-----

## Overview

OpenTelemetry is a vendor-neutral observability framework that provides APIs, SDKs, and tools to collect, process, and export telemetry data (traces, metrics, and logs). This example focuses on **tracing**, which allows you to:

- Track requests as they flow through your distributed system
- Identify performance bottlenecks
- Debug issues by following request paths
- Understand service dependencies

## Included Examples

This directory contains three tracing exporter examples:

| Example | Description | Use Case |
| :--- | :--- | :--- |
| **stdout** | Outputs traces to standard output (console) | Development and debugging |
| **jaeger** | Exports traces to Jaeger backend | Production tracing with Jaeger UI |
| **otlp_http_exporter** | Exports traces via OTLP HTTP protocol | Integration with any OTLP-compatible backend |

### stdout

The simplest tracing example that outputs trace data directly to the console. Perfect for:
- Quick development testing
- Understanding trace structure
- Debugging without external dependencies

**See**: [stdout/README.md](stdout/README.md)

### jaeger

Exports traces to Jaeger, a popular distributed tracing system. Includes:
- Full Jaeger UI integration
- Trace visualization and analysis
- Service dependency graphs

**See**: [jaeger/README.md](jaeger/README.md)

### otlp_http_exporter

Exports traces using the OpenTelemetry Protocol (OTLP) over HTTP. Compatible with:
- Any OTLP-compatible backend (Jaeger, Zipkin, Tempo, etc.)
- OpenTelemetry Collector
- Cloud observability platforms

**See**: [otlp_http_exporter/README.md](otlp_http_exporter/README.md)

## Quick Start

### Prerequisites

- Go 1.19 or higher
- Zookeeper (default: `127.0.0.1:2181`)
- For Jaeger example: Docker (to run Jaeger instance)

### Choose an Example

Select one of the examples based on your needs:

1. **For quick testing**: Use `stdout` - no external dependencies needed
2. **For visualization**: Use `jaeger` - requires Jaeger instance
3. **For production**: Use `otlp_http_exporter` - compatible with various backends

### Running an Example

Each example follows a similar pattern:

1. **Start the server**:
   ```bash
   cd <example-directory>
   go run ./go-server/cmd/main.go
   ```

2. **Start the client** (in a new terminal):
   ```bash
   cd <example-directory>
   go run ./go-client/cmd/main.go
   ```

3. **View traces**:
   - **stdout**: Check the server console output
   - **jaeger**: Open `http://localhost:16686` in your browser
   - **otlp_http_exporter**: Check your configured backend

For detailed instructions, refer to each example's README file.

## Configuration

Dubbo-Go tracing is configured using the `trace` package options. Common configuration includes:

### Basic Configuration

```go
import (
    "dubbo.apache.org/dubbo-go/v3/trace"
)

// Configure tracing with exporter
trace.WithStdoutExporter()        // For stdout
trace.WithJaegerExporter()        // For Jaeger
trace.WithOtlpHttpExporter(...)   // For OTLP HTTP
```