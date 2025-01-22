# replace lettre
import re

def replace_lettre(text):
    
    # Define additional normalization patterns and replacements
    replacements = {
        r'ſ': 's',  # Old 'long s' to modern 's'
        r'œ': 'oe',  # 'œ' replaced by 'oe'
        r'æ': 'ae',  # 'æ' replaced by 'ae'
        r'ę': 'ae',  # 'ę' replaced by 'ae'
        r'ā': 'a',  # Replace 'ā' with 'a'
        r'à': 'a',  # Replace 'à' with 'a'
        r'á': 'a',   # Replace á where a is one caracter
        r'á': 'a',  # Replace 'á' with 'a'
        r'è': 'e',  # Replace 'è' with 'e'
        r'è': 'e', # where è is one caracter
        r'é': 'e',  # Replace 'é' with 'e'
        r'é' : 'e',  # where é is one caracter
        r'ī': 'i',  # Replace 'ī' with 'i'
        r'í': 'i',  # Replace 'í' with 'i'
        r'î': 'i',  # Replace 'î' with 'i'
        r'ĩ': 'i',  # Replace 'ĩ' with 'i'
        r'ij': 'ii',  # Replace 'ij' with 'ii'
        r'ō': 'o',  # Replace 'ō' with 'o'
        r'ò': 'o',  # Replace 'ò' with 'o'
        r'ò': 'o',  # Replace ò where o is one caracter
        r'ó': 'o',  # Replace 'ó' with 'o'
        r'ū': 'u',  # Replace 'ū' with 'u'
        r'ú': 'u',  # Replace 'ú' with 'u'
        r'ù': 'u',  # Replace 'ù' with 'u'
        r'¬': '-',  # Replace '¬' with '-'
        r'ꝑ': 'per',  # Replace 'ꝑ' by 'per'
        r'ꝙ': 'qu', # Replace 'ꝙ' by 'qu'
        r'q;': 'que',  # Replace 'q;' with 'que'
    }
    # Apply each replacement
    for pattern, replacement in replacements.items():
        text = re.sub(pattern, replacement, text)

    return text