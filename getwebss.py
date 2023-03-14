#Saves the entered URL as image
#Make sure chrome is installed on your system!!!!

#USAGE : getwebss.py URL IMAGE_FILE_PATH
#EXAPLE: getwebss.py https://gogle.com c:\google_ss.png

import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys

# storing the arguments
arg1 = sys.argv[1]
arg2 = sys.argv[2]

chrome_options = Options()
chrome_options.add_argument("headless")
chrome_options.add_argument("--start-maximized")
chrome_options.add_argument('window-size=1920,1080')
driver = webdriver.Chrome(options=chrome_options)
driver.get("" + arg1)
driver.get_screenshot_as_file("" + arg2)
time.sleep(5)
driver.close()
driver.quit()
