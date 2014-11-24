import os

def dfUser():
    return 'roderick@datafloq.com'

def dfPass():
    password = os.popen('~/.offlineimap/pass.sh')

    return password.readline().strip()
