import os
from PIL import Image

image = Image.open('logo.png')

# IOS

def generateIOS(size, multiplier):
    imagexSizexMultiplier = image.resize((int(size*multiplier),int(size*multiplier)))
    imagexSizexMultiplier.save(os.path.dirname(os.getcwd()) + '\\ios\\Runner\\Assets.xcassets\\AppIcon.appiconset\\' + 'Icon-App-'+str(size)+'x'+str(size)+'@'+str(multiplier)+'x.png')

for i in range(3):
    generateIOS(20,i+1)
for i in range(3):
    generateIOS(29,i+1)
for i in range(3):
    generateIOS(40,i+1)
for i in range(2):
    generateIOS(60,i+2)
for i in range(3):
    generateIOS(76,i+1)  
generateIOS(83.5,2)  
generateIOS(1024,1)  


# Andoid

imagex72 = image.resize((72,72))
imagex48 = image.resize((48,48))
imagex96 = image.resize((96,96))
imagex144 = image.resize((144,144))
imagex192 = image.resize((192,192))

imagex72.save(os.path.dirname(os.getcwd()) + '\\android\\app\\src\\main\\res\\mipmap-hdpi\\' + 'ic_launcher.png')
imagex48.save(os.path.dirname(os.getcwd()) + '\\android\\app\\src\\main\\res\\mipmap-mdpi\\' + 'ic_launcher.png')
imagex96.save(os.path.dirname(os.getcwd()) + '\\android\\app\\src\\main\\res\\mipmap-xhdpi\\' + 'ic_launcher.png')
imagex144.save(os.path.dirname(os.getcwd()) + '\\android\\app\\src\\main\\res\\mipmap-xxhdpi\\' + 'ic_launcher.png')
imagex192.save(os.path.dirname(os.getcwd()) + '\\android\\app\\src\\main\\res\\mipmap-xxxhdpi\\' + 'ic_launcher.png')

print("Done.")