import os

def whiUser():
    return 'roderick@wehandle.it'

def whiPass():
    password = os.popen('~/.offlineimap/pass.sh')

    return password.readline().strip()
