"""
Normalize Latin text using a sequence of transformation functions.
-To extend the pipeline, add new transformation functions to the pipeline list.

"""

from utils.replace_symbol import replace_symbol
from utils.replace_tilde import replace_tilde
from utils.replace_lettre import replace_lettre

def normalize_latin_text(text):
  
    # Define the pipeline: an ordered list of transformation functions
    normalization_pipeline = [
        replace_symbol,  # Handle symbol replacements
        replace_tilde,    # Process tilde-related transformations
        replace_lettre,  # Normalize specific letters
    ]

    for func in normalization_pipeline:
        text = func(text)
    
    return text
