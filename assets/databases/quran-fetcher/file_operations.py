# file_operations.py

import os
import shutil  # Import shutil for file copying

def move_and_delete():
     # Define paths
    current_directory = os.path.abspath('.')
    source_file = os.path.join(current_directory, 'quran.db')
    destination_file = os.path.abspath('../quran.db')

    # Check if the source file exists
    if os.path.exists(source_file):
        # Copy the source file to the destination directory
        shutil.copyfile(source_file, destination_file)
        print(f"Copied file {source_file} to {destination_file}")
    else:
        print(f"Source file {source_file} does not exist.")

if __name__ == "__main__":
    move_and_delete()
