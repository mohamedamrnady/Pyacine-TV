from api.yacineapi import *
import pandas as pd
from tkinter import *
import os


ytv = YacineTV()

print(' ▄▄   ▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄ ▄▄    ▄ ▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄   ▄▄ ')
print('█  █ █  █      █       █   █  █  █ █       █ █       █  █ █  █ ')
print('█  █▄█  █  ▄   █       █   █   █▄█ █    ▄▄▄█ █▄     ▄█  █▄█  █ ')
print('█       █ █▄█  █     ▄▄█   █       █   █▄▄▄    █   █ █       █ ')
print('█▄     ▄█      █    █  █   █  ▄    █    ▄▄▄█   █   █ █       █ ')
print('  █   █ █  ▄   █    █▄▄█   █ █ █   █   █▄▄▄    █   █  █     █  ')
print('  █▄▄▄█ █▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄█▄█  █▄▄█▄▄▄▄▄▄▄█   █▄▄▄█   █▄▄▄█   ')
print('')
print('Script by Nady')
print('API by aimadnet')


def get_categories():
    global categories_tk
    categories_tk = Tk()
    categories_tk.geometry("200x450+50+50")
    try:
        categories = pd.DataFrame(ytv.get_categories()['data'])
        categories_ids = categories['id'].tolist()
        categories_names = categories['name'].tolist()
    except:
        print('Connection Failed. Try again later')
        exit()

    for counter, name in enumerate(categories_names):
        button = Button(categories_tk, text=name,
                        command=lambda x=categories_ids[counter]: get_category(x))
        button.pack()
    categories_tk.update()


def get_category(choice):
    global category_tk
    category_tk = Tk()
    category_tk.geometry("200x450+50+50")
    categories_tk.destroy()
    try:
        category_choice = pd.DataFrame(
            ytv.get_category_channels(choice)['data'])
        channels_names = category_choice['name'].tolist()
        channels_ids = category_choice['id'].tolist()
    except:
        print('Connection Failed. Try again later')
        exit()
    for counter, name in enumerate(channels_names):
        button = Button(
            category_tk, text=name, command=lambda x=channels_ids[counter]: get_channel(x))
        button.pack()
    category_tk.update()


def get_channel(choice):
    global channel_tk
    channel_tk = Tk()
    channel_tk.geometry("200x450+50+50")
    category_tk.destroy()
    try:
        channel_choice = pd.DataFrame(
            ytv.get_channel(choice)['data'])
        servers_names = channel_choice['name'].tolist()
        servers_urls = channel_choice['url'].tolist()
    except:
        print('Connection Failed. Try again later')
        exit()
    for counter, name in enumerate(servers_names):
        button = Button(
            channel_tk, text=name, command=lambda x=servers_urls[counter]: create_m3u8(x))
        button.pack()
    channel_tk.update()


def create_m3u8(url):
    print(url)
    with open('temp.m3u8', 'wb') as stream:
        stream.write(str.encode(url))
        stream.close
    os.startfile('temp.m3u8')


get_categories()
input()
