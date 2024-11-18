import os

for file in ['jokes', 'jokes_nsfw']:
  lua = file+'.lua'
  
  if os.path.exists(lua):
    os.remove(lua)

  source = open(file+'.txt', 'r')
  destination = open(lua, 'w')
  destination.write('return {')

  for line in source:
    destination.write('\n\t[[' + line.strip() + ']],')

  destination.write('\n}')
  source.close()
  destination.close()

