import requests
import sqlite3
import time

# Function to create SQLite table
def create_table():
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS Ayah (
                    id INTEGER PRIMARY KEY,
                    surah_id INTEGER NOT NULL,
                    ayah_number INTEGER NOT NULL,
                    ayah_key TEXT NOT NULL,
                    hizb_number INTEGER NOT NULL,
                    rub_el_hizb_number INTEGER NOT NULL,
                    ruku_number INTEGER NOT NULL,
                    manzil_number INTEGER NOT NULL,
                    sajdah_number INTEGER,
                    page_number INTEGER NOT NULL,
                    juz_number INTEGER NOT NULL,
                    text_uthmani TEXT NOT NULL,
                    transliteration TEXT NOT NULL,
                    FOREIGN KEY (surah_id) REFERENCES Surah(id)
                )''')
    conn.commit()
    conn.close()

# Function to insert data into SQLite table
def insert_data(ayahs):
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    for ayah in ayahs:
        c.execute('''INSERT INTO Ayah (surah_id, ayah_number, ayah_key, hizb_number, rub_el_hizb_number, ruku_number, manzil_number, sajdah_number, page_number, juz_number, text_uthmani, transliteration)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''', 
                    (ayah['surah_id'], ayah['verse_number'], ayah['verse_key'], ayah['hizb_number'], ayah['rub_el_hizb_number'], 
                    ayah['ruku_number'], ayah['manzil_number'], ayah['sajdah_number'], ayah['page_number'], ayah['juz_number'], 
                    ayah['text_uthmani'], 'TRANSLITERATION'))
    conn.commit()
    conn.close()

# Main function
def main():
    create_table()

    for i in range(1, 115):  # Loop through each surah (1 to 114)
        url = f'https://service.muslimin.eu/api/quran/surah/{i}'
        ayahs = fetch_data(url)
        insert_data(ayahs)
        print(f'Ayahs {i} inserted');
        time.sleep(0.1)  # Delay 1 second before fetching data for the next surah

    print("Data inserted successfully.")

# Fetch data from API
def fetch_data(url):
    response = requests.get(url)
    data = response.json()
    return data

if __name__ == "__main__":
    main()
