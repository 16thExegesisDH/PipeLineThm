import re
def replace_word(text):
    # add word that need a change after all the other normalization
    replacements = {
    r'\s+tamem':' tamen',
    r'\s+attamem':' attamen',
    r'\s+examem':' examen',
    r'\s+exen-':'exem-',
    r'\s+quen-':' quem-', 
    r'\s+ten-':' tem-', 
    r'\s+men-':' mem-',
    r'\s+aden-':' adem-',
    r'\s+adeum-':' adeun-',
    r'gimem':'gimen', # verifier sur enigma la combinaison *gimem n'existe pas en latin
    r'\s+etad':' et ad',
    r'\s+libus':' liber',
    r'qué ':'que ',
    r'qd ': 'quod',
    r' ́ ': '',
    } 
    
    for pattern, replacement in replacements.items():
        text = re.sub(pattern, replacement, text)        
        
    return text