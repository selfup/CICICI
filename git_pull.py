import os, sys, time

cicici_there = os.popen('ls').read()

if "CICICI" not in cicici_there:
    os.system('git clone https://github.com/selfup/CICICI')

os.system('cd ~/oxidizy_up && git pull && nohup cargo run --release &')
