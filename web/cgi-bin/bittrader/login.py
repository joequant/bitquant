#!/usr/bin/python
import pexpect
import os
import subprocess

os.environ['LC_ALL']="C"

def auth(username, password):
        '''Accepts username and password and tried to use PAM for authentication'''
        try:
                child = pexpect.spawn('/bin/su -f - %s -c "echo success"'%(username))
                child.expect('Password:')
                child.sendline(password)
                result=child.expect(['success'])
                child.close()
        except Exception as err:
                child.close()
                return False
        if result != 0:
                return False
        else:
                return True

def chpasswd(username, password):
	try:
            child = pexpect.spawn("sudo passwd %s" * username)
            child.expect("password:")
            child.sendline(password)
            child.expect("password:")
            child.sendline(password)
            child.close()
	except Exception as err:
            child.close()
	    return "exception"
	return "password changed"
	
if __name__ == '__main__':
        print auth(username='user',password='cubswin:)')
