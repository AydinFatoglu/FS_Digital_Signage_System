from tkinter import *
import tkinter as tk
import argparse


# Define Args
parser = argparse.ArgumentParser(description="Fullpage image display app! By Aydin Fataoglu")
parser.add_argument("wallpaper", help="Image to display!")
args = parser.parse_args()

master = tk.Tk()

master.attributes('-fullscreen', True)
master.config(cursor="none")

bgimg= tk.PhotoImage(file =((args.wallpaper)))
#Specify the file name present in the same directory or else
#specify the proper path for retrieving the image to set it as background image.
limg= Label(master, i=bgimg)
limg.pack()
master.mainloop()
