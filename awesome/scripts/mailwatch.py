#!/usr/bin/python3

import sys
import os
from pathlib import Path
import imaplib
import keyring
import getpass
# Create a list of emails to watch
# Add to keyring
# Add get from keyring

CONFIG_FILE = f"{os.path.expanduser('~')}/.config/mailwatch.conf"
KEYRING_SERVICE = "mailwatch"

def get_config_file(rwflag = "r"):
    if not os.path.isfile(CONFIG_FILE):
        Path(CONFIG_FILE).touch()
    return open(CONFIG_FILE, rwflag)

def write_email_list(emails):
    f = get_config_file("w")
    for email in emails:
        f.write(f"{email}\n")
    f.close()



def get_all_emails():
    f = get_config_file()
    emails = f.readlines()
    f.close()
    for i in range(0, len(emails)):
        emails[i] = emails[i].strip()
    
    return emails

def new_email(email):
    emails = get_all_emails()
    if email in emails:
        print("Email already exists in mailwatch")
        exit(1)
    
    emails.append(email)
    write_email_list(emails)

    passw = getpass.getpass("Password: ")
    keyring.set_password(KEYRING_SERVICE, email, passw)

def remove_email(email):
    emails = get_all_emails()
    if email in emails:
        emails.remove(email)
    
    write_email_list(emails)

    try:
        keyring.delete_password(KEYRING_SERVICE, email)
    except:
        print(f"No password found for {email}")

def check_unread():
    unread = 0
    emails = get_all_emails()
    for email in emails:
        try:
            info = email.split(":")
            imap_server = info[1]
            imap_user = info[0] 
            imap_password = keyring.get_password(KEYRING_SERVICE, email) 
            mail = imaplib.IMAP4_SSL(imap_server)
            (retcode, capabilities) = mail.login(imap_user,imap_password)
            mail.select('INBOX')

            (retcode, messages) = mail.search(None, '(UNSEEN)')
            unread = len(messages[0].split())
        except Exception as e:
            print(e, file=sys.stderr)

    print(unread)


def print_help():
    print("mailwatch <action> [args]")
    print("---")
    print("Actions:")
    print("    add '<email>:<server>'")
    print("    remove <email>")
    print("    list")


if __name__ == "__main__":
    args = sys.argv
    argslen = len(args)
    if argslen == 1:
        print_help()
        exit(0)

    action = args[1]
    if action == "add":
        if argslen < 3:
            print_help()
            exit(1)
        new_email(args[2])

    elif action == "list":
        for email in get_all_emails():
            print(email)

    elif action == "remove":
        if argslen < 3:
            print_help()
            exit(1)
        remove_email(args[2])

    elif action == "check":
        check_unread()


