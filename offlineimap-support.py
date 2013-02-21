import os

def whiUser():
    return 'roderick@wehandle.it'

def whiPass():
    password = os.popen('security find-generic-password -w -s mutt-WHI -a "roderick@wehandle.it"')

    return password.readline().strip()

def onmUser():
    return 'roderick@onmissbaar.nl'

def onmPass():
    password = os.popen('security find-generic-password -w -s mutt-ONM -a "roderick@onmissbaar.nl"')

    return password.readline().strip()
