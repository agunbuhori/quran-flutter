import requests
import sqlite3
import time

# Function to create SQLite tables
def create_tables():
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    c.execute('DROP TABLE IF EXISTS Kalimah')
    c.execute('''CREATE TABLE IF NOT EXISTS Kalimah (
                    id INTEGER PRIMARY KEY,
                    ayah_id INTEGER NOT NULL,
                    ayah_key TEXT NOT NULL,
                    position INTEGER NOT NULL,
                    audio_url TEXT,
                    location TEXT NOT NULL,
                    text_uthmani TEXT NOT NULL,
                    code_v1 TEXT NOT NULL,
                    code_v2 TEXT NOT NULL,
                    qpc_uthmani_hafs TEXT NOT NULL,
                    char_type_name TEXT NOT NULL,
                    page_number_v1 INTEGER NOT NULL,
                    page_number_v2 INTEGER NOT NULL,
                    line_number_v1 INTEGER NOT NULL,
                    line_number_v2 INTEGER NOT NULL,
                    translation TEXT NOT NULL,
                    transliteration TEXT,
                    FOREIGN KEY (ayah_id) REFERENCES Ayah(id)
                )''')
    conn.commit()
    conn.close()
    print("Table Kalimah created")

# Function to insert data into SQLite table
def insert_data(words, verse_id, verse_key):
    print(f"Trying to insert {verse_id} data")
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    for word in words:
        c.execute('''INSERT INTO Kalimah (ayah_id, position, audio_url, ayah_key, location, text_uthmani, code_v1, code_v2, qpc_uthmani_hafs, char_type_name, page_number_v1, page_number_v2, line_number_v1, line_number_v2, translation, transliteration)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''', 
                    (verse_id, word['position'], word['audio_url'], verse_key, word['location'], word['text_uthmani'], 
                    word['code_v1'], word['code_v2'], word['qpc_uthmani_hafs'], word['char_type_name'], word['page_number'], word['page_number'],
                    word['line_number'], word['line_number'], word['translation']['text'], word['transliteration']['text']))
    conn.commit()
    conn.close()
    print(f"Data {verse_id} inserted")

# Main function
def main():
    create_tables()

    for i in range(1, 115):  # Loop through each surah (1 to 114)
        url = f'https://api.qurancdn.com/api/qdc/verses/by_chapter/{i}?words=true&translation_fields=resource_name%2Clanguage_id&per_page=300&fields=text_uthmani%2Cchapter_id%2Chizb_number%2Ctext_imlaei_simple&translations=134&reciter=7&word_translation_language=id&page=1&word_fields=verse_key%2Cverse_id%2Cpage_number%2Clocation%2Ctext_uthmani%2Ccode_v2%2Ccode_v1%2Cqpc_uthmani_hafs%2Ctranslation%2Ctransliteration&mushaf=2'
        data = fetch_data(url)
        print(f"Data {i} fetched")
        for verse in data['verses']:
            insert_data(verse['words'], verse['id'], verse['verse_key'])
        
        time.sleep(0.5)  # Delay 0.5 seconds before fetching data for the next surah

    print("Data inserted successfully.")

# Fetch data from API
def fetch_data(url):
    response = requests.get(url)
    data = response.json()
    return data

if __name__ == "__main__":
    main()
