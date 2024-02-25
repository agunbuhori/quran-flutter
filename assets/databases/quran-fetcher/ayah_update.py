import requests
import sqlite3
import time
import json
import re
import file_operations


# Function to insert data into SQLite table
def update_data(verse, index):
    conn = sqlite3.connect('quran.db')
    c = conn.cursor()
    c.execute('''
        UPDATE Ayah SET text_uthmani = ? WHERE id = ?
    ''', (verse['text'], index))
    conn.commit()
    conn.close()
    print(f"Data {index} updated")

# Main function
def main():
    with open('ayah.json', 'r', encoding='utf-8') as file:
        data = json.load(file)

    index = 1
    # Now you can access the data
    for verse in data:
        update_data(verse, index)
        index += 1
    
    file_operations.move_and_delete()

# Fetch data from API
def fetch_data(url):
    response = requests.get(url)
    data = response.json()
    return data

if __name__ == "__main__":
    main()
