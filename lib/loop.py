import time, os

count = 0

while (count < 100):
    os.system('ruby deployer.rb')
    time.sleep(60)
