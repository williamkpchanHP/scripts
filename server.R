library(websocket)

# Define the websocket server URL
server_url <- "ws://localhost:8000"

# Function to handle websocket messages
handle_message <- function(ws, message) {
  print(paste("Received message:", message))
  
  # Send a response back to the HTML client
  response <- paste("Response from R:", message)
  ws$send(response)
}

# Create a websocket connection
ws <- websocket(server_url, onMessage = handle_message)

# Wait for messages indefinitely
websocket:::websocket_wait()
