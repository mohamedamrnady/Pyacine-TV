import os
from api.yacineapi import *
import pandas as pd

ytv = YacineTV()

print(' ▄▄   ▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄ ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄   ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄ ')
print('█  █ █  █      █       █   █  █  █ █       █       █  █ █  █  █       █       █   █')
print('█  █▄█  █  ▄   █       █   █   █▄█ █    ▄▄▄█▄     ▄█  █▄█  █  █   ▄   █    ▄  █   █')
print('█       █ █▄█  █     ▄▄█   █       █   █▄▄▄  █   █ █       █  █  █▄█  █   █▄█ █   █')
print('█▄     ▄█      █    █  █   █  ▄    █    ▄▄▄█ █   █ █       █  █       █    ▄▄▄█   █')
print('  █   █ █  ▄   █    █▄▄█   █ █ █   █   █▄▄▄  █   █  █     █   █   ▄   █   █   █   █')
print('  █▄▄▄█ █▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄█▄█  █▄▄█▄▄▄▄▄▄▄█ █▄▄▄█   █▄▄▄█    █▄▄█ █▄▄█▄▄▄█   █▄▄▄█')
print('')
print('Script by Nady')
print('API by aimadnet')

try:
    categories = pd.DataFrame(ytv.get_categories()['data'])
except:
    print('Connection Failed. Try again later')
    exit()
print('')
print('Choose a Category:')
print('')
for counter in range(0, categories['id'].count()):
    print('[' + str(categories.at[counter, 'id'])+'] ' +
          categories.at[counter, 'name'])

choice = str(input('Enter Your Choice : '))
category_choice = pd.DataFrame(ytv.get_category_channels(choice)['data'])
print('')
print('Choose a Channel:')
print('')
for counter in range(0, category_choice['id'].count()):
    print('[' + str(category_choice.at[counter, 'id'])+'] ' +
          category_choice.at[counter, 'name'])

choice = str(input('Enter Your Choice : '))

channel_choice = pd.DataFrame(ytv.get_channel(choice)['data'])
print('')
print('Choose a Server:')
print('')
for counter in range(0, channel_choice['name'].count()):
    print('[' + str(counter) + '] ' +
          channel_choice.at[counter, 'name'])

choice = str(input('Enter Your Choice : '))

with open('temp.m3u8', 'wb') as stream:
    stream.write(str.encode(channel_choice.at[int(choice), 'url']))
    stream.close
os.startfile('temp.m3u8')
