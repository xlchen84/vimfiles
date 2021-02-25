# -*- coding: utf-8 -*-
import vim
import logging.config
from logging import StreamHandler
from logging.handlers import RotatingFileHandler

log_file  = vim.vars['logging_logfile']
log_level = logging.DEBUG
fileHandler = logging.FileHandler(log_file)
fileHandler.setLevel(log_level)
formatter = logging.Formatter("[%(levelname)s][%(funcName)s][%(asctime)s]%(message)s") 
fileHandler.setFormatter(formatter)
streamHandler = logging.StreamHandler()
streamHandler.setLevel(log_level)
rootLogger = logging.getLogger('root')
rootLogger.setLevel(log_level)
if not rootLogger.hasHandlers():
    rootLogger.addHandler(fileHandler)
    rootLogger.addHandler(streamHandler)
    rootLogger.debug('adding handlers to root logger')

vim.vars['logging_root_logger_has_handlers'] = rootLogger.hasHandlers()

