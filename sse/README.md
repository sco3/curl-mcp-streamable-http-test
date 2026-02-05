# SSE Streamable HTTP Test

This project provides a test script to verify Server-Sent Events (SSE) for a streamable HTTP connection.

## Description

The `test-init-sse.sh` script simulates a client connecting to an SSE endpoint, sending JSON-RPC messages, and receiving events. The script uses `curl` to manage the HTTP connection and `tmux` to run the client in the background.

The `sse.txt` file is a log of the events received from the server during the test.

## Usage

To run the test, execute the following command:

```bash
./test-init-sse.sh
```

**Prerequisites:**
- `tmux` must be installed.
- A server that implements the tested protocol must be running on `http://127.0.0.1:8888`.

## Files

- `test-init-sse.sh`: The main test script.
- `sse.txt`: A sample output file containing the SSE events.
