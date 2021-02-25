# -*- coding: utf-8 -*-
import vim
import logging.config
from logging.handlers import RotatingFileHandler as FileHandler

logging_conf = vim.vars['logging_conf']

try:
    logging.config.fileConfig(logging_conf)
    logging.debug('logging configuration: %s' % logging_conf)
    rootLogger = logging.getLogger('root')
    if rootLogger.hasHandlers():
        logging_logfile  = rootLogger.handlers[0].stream.name
        logging.debug('log file is %s', logging_logfile)
        vim.vars['logging_logfile'] = logging_logfile  
    else:
        logfile = vim.vars['logging_logfile']
        fileHandler = FileHandler(logfile)
        rootLogger.addHandler(fileHandler)
        streamHandler = logging.StreamHandler()
        rootLogger.addHandler(streamHandler)
        rootLogger.debug('adding handlers to root logger')
        logging.debug('rootLogger handlers empty')
except:
    pass


def debug(*args, **kwargs):
    rootLogger = logging.getLogger('root')
    if rootLogger:
        rootLogger.debug(*args, **kwargs)

    #fileHandler.setLevel(log_level)
    #formatter = logging.Formatter("[%(levelname)s][%(funcName)s][%(asctime)s]%(message)s") 
    #fileHandler.setFormatter(formatter)
    #streamHandler.setLevel(log_level)
    #rootLogger.setLevel(log_level)
    #vim.vars['logging_root_logger_has_handlers'] = rootLogger.hasHandlers()

