import requests
import sqlite3

# Function to create SQLite table
def create_table():
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS Surah (
                    id INTEGER PRIMARY KEY,
                    revelation_place TEXT NOT NULL,
                    revelation_order INTEGER NOT NULL,
                    bismillah_pre INTEGER NOT NULL,
                    name_simple TEXT NOT NULL,
                    name_complex TEXT NOT NULL,
                    name_arabic TEXT NOT NULL,
                    name_indonesian TEXT NOT NULL,
                    ayahs_count INTEGER NOT NULL,
                    page_start INTEGER NOT NULL,
                    page_end INTEGER NOT NULL
                )''')
    conn.commit()
    conn.close()

def replace_substrings(input_string):
    replacements = {
        'aw': 'au',
        'th': 'ts',
        'sh': 'sy'
    }
    result = ""
    i = 0
    while i < len(input_string):
        found = False
        for substring, replacement in replacements.items():
            if input_string[i:i+len(substring)].lower() == substring:
                if input_string[i:i+len(substring)].islower():
                    result += replacement
                elif input_string[i:i+len(substring)].istitle():
                    result += replacement.title()
                else:
                    result += replacement.upper()
                i += len(substring)
                found = True
                break
        if not found:
            result += input_string[i]
            i += 1
    return result

# Example usage:
input_str = "The shadow of the dawn"
output_str = replace_substrings(input_str)
print(output_str)  # Output: "Ts syadow of the dawn"


# Function to insert data into SQLite table
def insert_data(chapters):
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    for chapter in chapters:
        c.execute('''INSERT INTO Surah (id, revelation_place, revelation_order, bismillah_pre, name_simple, name_complex, name_arabic, ayahs_count, page_start, page_end, name_indonesian)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''', 
                    (chapter['id'], chapter['revelation_place'], chapter['revelation_order'], chapter['bismillah_pre'], replace_substrings(chapter['name_simple']), 
                    replace_substrings(chapter['name_complex']), chapter['name_arabic'], chapter['verses_count'], chapter['pages'][0], chapter['pages'][1], 
                    chapter['translated_name']['name']))
    conn.commit()
    conn.close()

# Fetch data from API
url = 'https://api.quran.com/api/v4/chapters?language=id'
response = requests.get(url)
data = response.json()
chapters = data['chapters']

# Create SQLite table
create_table()

# Insert data into SQLite table
insert_data(chapters)

print("Data inserted successfully.")