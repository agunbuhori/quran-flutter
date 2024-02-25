import requests
import sqlite3

def fetch_data(url):
    response = requests.get(url)
    data = response.json()
    return data

def insert_data_to_ayah_translation(verses):
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()

    for verse in verses:
        c.execute(f"INSERT INTO AyahTranslation(translator_id, translation, ayah_id) VALUES(?, ?, ?)", (1, verse['translations'][0]['text'], verse['id']))
        print(f"Inserted {verse['id']}")
    conn.commit()
    conn.close()

for i in range(1, 115):
    result = fetch_data(f"https://api.quran.com/api/v4/verses/by_chapter/{i}?translations=134&per_page=300")
    insert_data_to_ayah_translation(result['verses'])