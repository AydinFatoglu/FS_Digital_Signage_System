from tkinter import *
import tkinter as tk
import argparse
import socket

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

# hostname of the socket
hostname = socket.gethostname()

label1 = Label(master, text="" + hostname)
label1.pack(pady=50)
label1.config(font=("Courier", 33))
label1.config(fg="white")
label1.config(bg="black")
# using place method we can set the position of label
label1.place(relx = 0.0,
                 rely = 1.0,
                 anchor ='sw')
