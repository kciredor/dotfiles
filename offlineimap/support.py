import os

def dfUser():
    return 'roderick@bigdata-startups.com'

def dfPass():
    password = os.popen('~/.offlineimap/pass.sh')

    return password.readline().strip()
