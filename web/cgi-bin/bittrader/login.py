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
	dev_null = open('/dev/null', 'w')
	passwd = subprocess.Popen(['sudo', 'passwd', user],
				  stdin=subprocess.PIPE,
				  stdout=dev_null.fileno(),
				  stderr=subprocess.STDOUT)
	passwd.communicate( ((phrase + '\n')*2).encode('utf-8') )
	if passwd.returncode != 0:
		raise OSError('password setting failed')
	    
if __name__ == '__main__':
        print auth(username='user',password='cubswin:)')
