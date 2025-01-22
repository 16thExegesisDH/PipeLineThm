import re

def replace_tilde(text):
    # Replace ã followed by optional ¬ and d or t with an, preserving the d or t
    text = re.sub(r'ã¬?([cdt])', r'an\1', text)
    # Replace ã followed by optional ¬ and any other character with am, preserving that character
    text = re.sub(r'ã¬?([^\S\r\n<]|.)', lambda m: 'am ' if m.group(1).isspace() else 'am' + m.group(1), text)
    # Replace ã at the end of a line with am
    text = re.sub(r'ã¬?$', 'am', text, flags=re.MULTILINE)
    
    # Replace ẽ followed by optional ¬ and d or t with en, preserving the d or t
    text = re.sub(r'ẽ¬?([dst])', r'en\1', text)
    # Replace ẽ followed by optional ¬ and any other character with em, preserving that character
    text = re.sub(r'ẽ¬?([^\S\r\n<]|.)', lambda m: 'em ' if m.group(1).isspace() else 'em' + m.group(1), text)
    # Replace ẽ at the end of a line with em
    text = re.sub(r'ẽ¬?$', 'em', text, flags=re.MULTILINE)

    # Replace õ followed by optional ¬ and p or b with om, preserving the p or b
    text = re.sub(r'õ¬?([pb])', r'om\1', text)
    # Replace õ followed by optional ¬ and any other character with on, preserving that character
    text = re.sub(r'õ¬?([^pb])', r'on\1', text)
    # Replace õ at the end of a line with on
    text = re.sub(r'õ¬?$', 'on', text, flags=re.MULTILINE)
    
    # Replace ũ followed by optional ¬ and t with un, preserving the t
    text = re.sub(r'ũ¬?([ct])', r'un\1', text)
    # Replace ũ followed by optional ¬ and any other character with um, preserving that character
    text = re.sub(r'ũ¬?([^\S\r\n<]|.)', lambda m: 'um ' if m.group(1).isspace() else 'um' + m.group(1), text)
    # Replace ũ at the end of a line with um
    text = re.sub(r'ũ¬?$', 'um', text, flags=re.MULTILINE)
    
    #bug with special caracter : õ
    # Replace õ where "õ" is one unice lettre followed by optional ¬ and p or b with om, preserving the p or b
    text = re.sub(r'õ¬?([pb])', r'om\1', text)
    # Replace õ followed by optional ¬ and any other character with on, preserving that character
    text = re.sub(r'õ¬?([^pb])', r'on\1', text)
    # Replace õ at the end of a line with on
    text = re.sub(r'õ¬?$', 'on', text, flags=re.MULTILINE)
    
    #bug with special caracter : ẽ
    # Replace ẽ where "ẽ" is one unice lettre followed by optional ¬ and d or t with en, preserving the d or t
    text = re.sub(r'ẽ¬?([dst])', r'en\1', text)
    # Replace ẽ followed by optional ¬ and any other character with em, preserving that character
    text = re.sub(r'ẽ¬?([^\S\r\n<]|.)', lambda m: 'em ' if m.group(1).isspace() else 'em' + m.group(1), text)
    # Replace ẽ at the end of a line with em
    text = re.sub(r'ẽ¬?$', 'em', text, flags=re.MULTILINE)

    return text
