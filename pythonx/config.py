# -*- coding: utf-8 -*-
import vim
import logging.config

logging_conf = vim.vars['logging_conf']

try:
    logging.config.fileConfig(logging_conf)
    logging.debug('logging configuration: %s' % logging_conf)
    rootLogger = logging.getLogger('root')
    if len(rootLogger.handlers) > 0:
        logging_logfile  = rootLogger.handlers[0].stream.name
        logging.debug('log file is %s', logging_logfile)
        vim.vars['logging_logfile'] = logging_logfile  
    else:
        logging.debug('rootLogger handlers empty')
except:
    pass
    #fileHandler = logging.FileHandler(log_file)
    #fileHandler.setLevel(log_level)
    #formatter = logging.Formatter("[%(levelname)s][%(funcName)s][%(asctime)s]%(message)s") 
    #fileHandler.setFormatter(formatter)
    #streamHandler = logging.StreamHandler()
    #streamHandler.setLevel(log_level)
    #rootLogger.setLevel(log_level)
    #if not rootLogger.hasHandlers():
    #    rootLogger.addHandler(fileHandler)
    #    rootLogger.addHandler(streamHandler)
    #    rootLogger.debug('adding handlers to root logger')
    #vim.vars['logging_root_logger_has_handlers'] = rootLogger.hasHandlers()

