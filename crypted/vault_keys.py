#!/usr/bin/env python
# coding=utf-8
import argparse

from ansible.parsing.vault import VaultLib
import yaml

def setup_arg_parser():
    parser = argparse.ArgumentParser(description='Get value for a given key')
    parser.add_argument('key',
                        help='Key variable')
    return parser

def get_key_value(key):
    vault_password = open("/tmp/.vaultpwd").readlines()[0].rstrip('\n')
    data = open("keychain.yml").read()

    vault = VaultLib(password=vault_password)
    if vault.is_encrypted(data):
        data = vault.decrypt(data)
        ydata = yaml.load(data)
        return ydata['aws'][key]
    else:
        return None


def main():
    parser = setup_arg_parser()
    args = parser.parse_args()
    print get_key_value(args.key)

if __name__ == "__main__":
    main()