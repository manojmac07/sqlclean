import configparser
import logging
import logging.config
import os

class ConfigDatabase:
    logging.config.fileConfig(r'C:\Users\MAC\Desktop\crudapi\yaraproject\db\resources\configs\logging.conf',)
    #logging.config.fileConfig('yaraproject/db/resources/configs/logging.conf',)
    logger = logging.getLogger('AccessDataBase')
    logger.debug('logging.conf got')
    db_info = configparser.ConfigParser()
    filepath = r'C:\Users\MAC\Desktop\crudapi\yaraproject\db\resources\database.ini'
    db_info.read(filepath)
    logger.debug('database.ini got')
    logger.info(str(db_info.sections()))

    postgres_access = {value[0]: value[1] for value in db_info.items('POSTGRES_CONNECT')}
    logger.info(postgres_access)
    new_value = os.environ.get('DATABASE_HOST')
    if new_value == os.environ.get('DATABASE_HOST'):
        postgres_access['host'] = new_value
    if new_value == os.environ.get('DATABASE_PASSWORD'):
        postgres_access['password'] = new_value
    if new_value == os.environ.get('DATABASE_DATABASE'):
        postgres_access['database.ini'] = new_value
    if new_value == os.environ.get('DATABASE_USER'):
        postgres_access['user'] = new_value
    table_name = db_info.get('MESSAGES_TABLE', 'table_name')
    logger.debug('DATABASE INFO CONFIGURED')