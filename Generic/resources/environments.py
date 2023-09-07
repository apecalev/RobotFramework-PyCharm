def getBaseURL(env):

    if env == 'QA1':
        domain = 'qa1-www.domain.com/'

    elif env == 'QA2':
        domain = 'qa2-www.domain.com/'

    elif env == 'PROD':
        domain = 'www.domain.com/'

    elif env == 'STG':
        domain = 'stg-www.domain.com/'

    return 'http://' + domain
