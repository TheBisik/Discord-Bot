# Discord Bot with Flask API

## Overview

This repository contains a Python script that integrates a Discord bot with a Flask web API. The bot allows users to send messages to specified Discord channels by making HTTP POST requests to the Flask server.

## Features

- **Discord Integration**: The bot uses the `discord.py` library to interact with Discord channels and send messages.
- **Flask API**: A web server is created using the Flask framework to expose an API endpoint (`/send_message`) that accepts HTTP POST requests to send messages to specific Discord channels.
- **IPv6 Support**: The Flask API listens on an IPv6 address (`::`) on port `30119`.
- **Multi-threading**: The Flask server runs in a separate thread to allow both the web API and the Discord bot to run concurrently in the same process.

## Requirements

- Python 3.x
- `discord.py` library
- Flask library
- Threading library
- Asyncio library

You can install the necessary libraries using pip:

```bash
pip install discord.py Flask
```

## POST sending pattern
Supports discord api
- Change "content" to "message"

```
{
"channel_id":"", 
  "message": "✨ Hellow World ✨",
  "tts": false,
  "embeds": [],
  "components": [],
  "actions": {}
}
```

## How It Works

1. Flask API: The Flask server exposes an API endpoint /send_message that accepts POST requests with JSON data.
- Example JSON body:
```
{
"channel_id": "123456789012345678",
"message": "Hello, Discord!"
}
```

2. Discord Bot: The bot connects to Discord and listens for incoming requests. When a request is received at `/send_message`, the bot fetches the specified channel by its ID and sends the message provided in the request.

3. Multithreading: The Flask server is run in a separate thread from the Discord bot, allowing both the web server and the bot to function simultaneously.

## API Endpoint
#### POST `/send_message`

-- Description: Sends a message to a specified Discord channel.

-- Request Body:
- `channel_id`: The ID of the Discord channel where the message will be sent.
- `message`: The message to be sent.

#### Example:
```
curl -X POST http://[::1]:30119/send_message \
-H "Content-Type: application/json" \
-d '{"channel_id": "123456789012345678", "message": "Hello, Discord!"}'
```
#### Response:

- `200 OK: Message`: sent successfully.
- `400 Bad Request`: Invalid request data.
- `404 Not Found`: Invalid channel ID.

## Configuration

- Bot Token: Make sure to replace `YOUR_BOT_TOKEN` in the script with your actual Discord bot token.

- Channel ID: Provide the correct `channel_id` in your POST requests to ensure messages are sent to the correct channel.

## RUN
#### Go to Build directory and run as Admin(`sudo`) ```./build_discord_bot.sh```
## Notes
- The Flask server is configured to listen on all IPv6 addresses (`::`) and port `30119`. Adjust the configuration if necessary.

- Ensure that the bot has the necessary permissions in the Discord server to send messages to the specified channel.

Brief explanation:

- Discord Auto Build Bot: This is a hobbyist project
- The bot receives POST messages and forwards them to the specified channel
- Skyrpt builds the bot automatically nothing needs to be done except simple configuration
- Bot starts automatically after unchecking the last section of #python3 /home/discrod/botdsc.py
