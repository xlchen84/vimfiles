# -*- coding: utf-8 -*-
import vim
import logging.config
from logging.handlers import RotatingFileHandler as FileHandler

try:
    logging.config.fileConfig('logging.conf')
    rootLogger = logging.getLogger('root')
    # print('root Logger is {}'.format(rootLogger))
    if rootLogger.hasHandlers():
        # print('root Logger handers are {}'.format(rootLogger.handlers))
        logfile  = rootLogger.handlers[0].stream.name
        # print('log file is {}'.format(logfile))
        vim.vars['logfile'] = logfile
    else:
        if vim.vars.has_key('logfile'):
            logfile = vim.vars['logfile']
        else:
            logfile = '~/vimfiles/debug.log'
        print('root Logger handers are {}'.format(rootLogger.handlers))
        fileHandler = FileHandler(logfile)
        rootLogger.addHandler(fileHandler)
        print('root Logger handers are {}'.format(rootLogger.handlers))
        streamHandler = logging.StreamHandler()
        rootLogger.addHandler(streamHandler)
        print('root Logger handers are {}'.format(rootLogger.handlers))
        rootLogger.debug('adding handlers to root logger')
except:
    print('logging initialize failed.')

def debug(message, *args, **kwargs):
    logging.debug(message.format(*args, **kwargs))
