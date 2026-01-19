#!/usr/bin/env -S bash

URL="http://127.0.0.1:8000/mcp"

curl -N -s -X POST \
	-H "Content-Type: application/json" \
	-H "Accept: application/json, text/event-stream" \
	-D headers.txt \
	-d '{
    "jsonrpc": "2.0",
    "method": "initialize",
    "params": {
      "protocolVersion": "2025-03-26",
      "capabilities": {},
      "clientInfo": {
        "name": "curl-test",
        "version": "1.0.0"
      }
    },
    "id": 1
  }' \
	"$URL"

SESSION_ID=$(grep -i "mcp-session-id" headers.txt | cut -d' ' -f2 | tr -d '\r')
echo "Session ID: $SESSION_ID"

curl -s -X POST \
	-H "Content-Type: application/json" \
	-H "Accept: application/json, text/event-stream" \
	-H "Mcp-Session-Id: $SESSION_ID" \
	-d '{
    "jsonrpc": "2.0",
    "method": "notifications/initialized"
  }' \
	$URL

curl -s -X POST $URL \
	-H "Content-Type: application/json" \
	-H "Accept: application/json, text/event-stream" \
	-H "Mcp-Session-Id: $SESSION_ID" \
	-d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/list"
  }' | yq .data | yq -P -o json >tools.json

curl -s -X POST $URL \
	-H "Content-Type: application/json" \
	-H "Accept: application/json, text/event-stream" \
	-H "Mcp-Session-Id: $SESSION_ID" \
	-d '{
    "jsonrpc": "2.0",
    "id": 3,
    "method": "tools/call",
    "params": {
      "name": "get_value",
      "arguments": {}
    }
  }'
