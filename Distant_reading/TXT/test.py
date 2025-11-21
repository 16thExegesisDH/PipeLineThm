import os
import re

def clean_text(text):
    # 1. Fix inline hyphens: "agnitio- nem" → "agnitionem"
    text = re.sub(r'(\w)-\s+(\w)', r'\1\2', text)

    # 2. Remove soft hyphens (invisible OCR hyphens)
    text = text.replace('\u00AD', '')

    # 3. Remove hyphen + newline (in case those also appear)
    text = re.sub(r'-\s*\r?\n\s*', '', text)

    return text


def process_file(path):
    with open(path, "r", encoding="utf-8") as f:
        original = f.read()

    cleaned = clean_text(original)

    if cleaned != original:
        with open(path, "w", encoding="utf-8") as f:
            f.write(cleaned)
        print(f"[CLEANED]", path)
    else:
        print(f"[NO CHANGES]", path)


def process_folder(folder):
    for root, dirs, files in os.walk(folder):
        for fn in files:
            if fn.lower().endswith(".txt"):
                process_file(os.path.join(root, fn))


def main():
    folder = input("Enter folder to clean recursively: ").strip()
    process_folder(folder)


if __name__ == "__main__":
    main()
