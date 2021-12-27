#! /usr/bin/env python2
# -*- coding: utf8 -*-

from subprocess import check_output

def get_pass():
    return check_output("pass gmail/me", shell=True).strip("\n")
