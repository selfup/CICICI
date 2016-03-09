import time, os, sys

count = 0

while (count < 100):
    try:
        script, opscmd = sys.argv
        print opscmd
        os.system('ruby main.rb %s' % opscmd)
        time.sleep(60)

    except ValueError:
        os.system('ruby main.rb')
        time.sleep(60)
