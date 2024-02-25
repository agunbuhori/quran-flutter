import requests
import sqlite3
import time

# Function to insert data into SQLite table
def insert_data(words, verse_id, verse_key):
    print(f"Trying to insert {verse_id} data")
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    for word in words:
        c.execute('''
            UPDATE Kalimah SET line_number_v1 = ?, page_number_v1 = ? WHERE ayah_id = ? AND position = ?
        ''', (word['line_number'], word['page_number'], verse_id, word['position']))
    conn.commit()
    conn.close()
    print(f"Data {verse_id} updated")

# Main function
def main():
    for i in range(1, 115):  # Loop through each surah (1 to 114)
        url = f'https://api.qurancdn.com/api/qdc/verses/by_chapter/{i}?words=true&translation_fields=resource_name%2Clanguage_id&per_page=300&fields=text_uthmani%2Cchapter_id%2Chizb_number%2Ctext_imlaei_simple&translations=134&reciter=7&word_translation_language=id&page=1&word_fields=verse_key%2Cverse_id%2Cpage_number%2Clocation%2Ctext_uthmani%2Ccode_v2%2Ccode_v1%2Cqpc_uthmani_hafs%2Ctranslation%2Ctransliteration&mushaf=1'
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
