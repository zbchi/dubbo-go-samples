#!/bin/bash

# 运行 CORS 示例

echo "Starting CORS server..."
cd go-server/cmd
go run main.go &
SERVER_PID=$!
echo "Server PID: $SERVER_PID"

# 等待服务器启动
sleep 3

echo "Running CORS client..."
cd ../../go-client/cmd
go run main.go

# 清理
kill $SERVER_PID 2>/dev/null







