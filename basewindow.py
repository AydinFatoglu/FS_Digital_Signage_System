# Import module 
from tkinter import *
import argparse

%Run bg.py
# Define Args
parser = argparse.ArgumentParser(description="Fullpage image display app! By Aydin Fataoglu")
parser.add_argument("wallpaper", help="Image to display!")
args = parser.parse_args()

# Create object 
root = Tk()
root.attributes('-fullscreen', True)
root.config(cursor="none")

# Add image file
bg = PhotoImage(file =((args.wallpaper)))
  
# Show image using label
label1 = Label( root, image = bg)
label1.place(x = -2, y = -2)

# Execute tkinter
root.mainloop()
