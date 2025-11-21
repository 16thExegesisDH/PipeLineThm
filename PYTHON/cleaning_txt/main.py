import os
import re

def clean_text(text):
    """
    Clean hyphenated line breaks such as:
        "grati-\nam" → "gratiam"
    """
    # Remove hyphen + optional spaces + newline + optional spaces
    text = re.sub(r'-\s*\n\s*', '', text)
    return text


def process_file(file_path):
    """
    Reads a .txt file, cleans it, and writes it back only if modified.
    """
    with open(file_path, "r", encoding="utf-8") as f:
        original = f.read()

    cleaned = clean_text(original)

    if cleaned != original:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(cleaned)
        print(f"[CLEANED] {file_path}")
    else:
        print(f"[OK] No changes: {file_path}")


def process_folder(root_folder):
    """
    Recursively walk through folder and process all .txt files.
    """
    for root, dirs, files in os.walk(root_folder):
        for name in files:
            if name.lower().endswith(".txt"):
                full_path = os.path.join(root, name)
                process_file(full_path)


def main():
    folder = input("Enter folder to clean recursively: ").strip()
    if not os.path.isdir(folder):
        print("Error: Not a valid folder.")
        return
    process_folder(folder)


if __name__ == "__main__":
    main()
