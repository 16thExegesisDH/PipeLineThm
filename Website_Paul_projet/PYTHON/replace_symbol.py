# replace_symbol.py
import re
def replace_symbol(text):
    # Replace specific symbols and patterns
    # concerne any exception that have to be done befor any transformation (add tamen)
    replacements = {
        r'¬': '-',     # Replace ¬ with -
        r'nõ': 'non',  # Replace nõ with non
        r'&amp;': 'et' , # Normalize '&amp;' to 'et'
    }
     # Apply each replacement
    for pattern, replacement in replacements.items():
        text = re.sub(pattern, replacement, text)
    
    return text