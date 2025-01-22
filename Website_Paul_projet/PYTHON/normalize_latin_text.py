# normalization pipeline

import replace_symbol
import replace_tilde
import replace_lettre

def normalize_latin_text(text):
    # Define the order of operations
    # each new function can be add here
    normalization_pipeline = [
        replace_symbol.replace_symbol,
        replace_tilde.replace_tilde,
        replace_lettre.replace_lettre,
    ]
    
    for func in normalization_pipeline:
        text = func(text)
    return text