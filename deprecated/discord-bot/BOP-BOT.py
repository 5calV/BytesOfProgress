import discord
from discord.ext import commands
import os

intents = discord.Intents.all()
intents.messages = True

bot = commands.Bot(command_prefix='/', intents=intents, case_insensitive=True)

@bot.event
async def on_ready():
    print('Logged in as')
    print(bot.user.name)
    print(bot.user.id)
    print('------')

@bot.command()
async def bop(ctx, *, query=None):
    if query is None:
        await ctx.send("Please enter a query.")
        return

    print(f"Received query: {query}")
    results = search_files(query)
    print("Results:", results)
    if results:
        print("Sending results...")

        message = f'"{query}" was found in BytesOfProgress:\n'
        for result in results:
            message += result + "\n"
        await ctx.send(message)
    else:
        print("No results found.")
        await ctx.send("Has not been found in BytesOfProgress.")

def search_files(query):
    results = []
    root_dir = "/var/www/html"
    base_url = "https://bytesofprogress.io/"
    for dirpath, _, filenames in os.walk(root_dir):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            if os.path.isfile(filepath):
                try:
                    with open(filepath, "r", encoding="utf-8") as file:
                        content = file.read()
                        if query.lower() in content.lower():
                            url = base_url + os.path.relpath(filepath, root_dir)
                            results.append(url)
                            print("Query found in file:", url)
                except Exception as e:
                    print(f"Error reading file {filepath}: {e}")
    return results




# bot.run('TOKEN')
