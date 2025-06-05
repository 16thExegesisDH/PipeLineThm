import re
def replace_word(text):
    # add word that need a change after all the other normalization
    replacements = {
    r'\s+aĩa': ' anima',
    r'\s+tamem':' tamen',
    r'\s+attamem':' attamen',
    r'\s+dñ':' domin',
    r'\s+examem':' examen',
    r'\s+exen-':' exem-',
    r'\s+homĩ':' homin',
    r'\s+igit̃':' igitur',
    r'\s+quen-':' quem-', 
    r'\s+ten-':' tem-', 
    r'\s+men-':' mem-',
    r'\s+oens':' omnes',
    r'\s+aden-':' adem-',
    r'\s+adeum-':' adeun-',
    r'gimem':'gimen', # verifier sur enigma la combinaison *gimem n'existe pas en latin
    r'\s+etad':' et ad',
    r'\s+gr̃':'grati', # abréviation de gratia
    r'\s+libus':' liber',
    #r'\s+oĩa':' omnia',
    r'qué ':'que ',
    r'qd ': 'quod',
    r'\s+spums':' spiritus ',
    r' ́ ': '',
    r'\s+Ed':' Et',
    r'ꝗ ipse': 'qui ipse',
    } 
    
    for pattern, replacement in replacements.items():
        text = re.sub(pattern, replacement, text)        
        
    return text