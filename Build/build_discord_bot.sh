#!/bin/bash

# Tworzenie katalogu dla bota
sudo mkdir -p /home/discord

# Tworzenie pliku Python z kodem bota Discord
sudo tee /home/discord/discordbot.py > /dev/null <<EOL
from flask import Flask, request
import discord
import asyncio
import threading

app = Flask(__name__)

# Definiowanie intents
intents = discord.Intents.default()
intents.messages = True
intents.guilds = True

client = discord.Client(intents=intents)

@app.route('/send_message', methods=['POST'])
def send_message():
    data = request.json
    if not data or 'channel_id' not in data or 'message' not in data:
        return "Invalid request data", 400

    channel_id = data['channel_id']
    message = data['message']
    channel = client.get_channel(int(channel_id))  # Upewnij się, że channel_id jest liczbą całkowitą

    if channel:
        asyncio.run_coroutine_threadsafe(channel.send(message), client.loop)
        return "Message sent successfully", 200
    else:
        return "Invalid channel ID", 404

def run_flask():
    app.run(host='::', port=30119)  # Nasłuchuj na wszystkich adresach IPv6

if __name__ == '__main__':
    # Uruchomienie Flask w osobnym wątku
    flask_thread = threading.Thread(target=run_flask)
    flask_thread.start()

    # Uruchomienie bota Discord
    client.run('YOUR_BOT_TOKEN')  # Zastąp 'YOUR_BOT_TOKEN' rzeczywistym tokenem bota
EOL

# Tworzenie skryptu startowego dla OpenRC
sudo tee /etc/local.d/discordbot.start > /dev/null <<EOL
#!/bin/sh
python3 /home/discord/discordbot.py
EOL

# Nadanie uprawnień do uruchamiania skryptu
sudo chmod +x /etc/local.d/discordbot.start

# Dodanie skryptu do uruchamiania przy starcie systemu
sudo rc-update add local default

# Uruchomienie skryptu
sudo rc-service local start

#Start Bota                                     //Trzeba Odznaczyć!!!!
#python3 /home/discrod/botdsc.py