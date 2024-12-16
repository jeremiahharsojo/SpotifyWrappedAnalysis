import pandas as pd
import os 
import re

def find_files(directory, pattern): #Returns an array of filenames that follow the specified pattern in a directory
    matching_files = [] 
    regex = re.compile(pattern) 
    for root, dirs, files in os.walk(directory): 
        for filename in files: 
            if regex.match(filename): 
                matching_files.append(os.path.join(root, filename)) 
    return matching_files

def convert_csv(files, filename):   #Converts an array of .json filenames into a single .csv file with specified filename
    dataframes = []
    for i in files:
        df = pd.read_json(i) 
        dataframes.append(df)
    combined_df = pd.concat(dataframes, ignore_index=True)
    combined_df.to_csv(filename, index=False)

directory_to_search = r"C:\Users\jerem\OneDrive\Documents\Random Code\Spotify Account Data\RAW DATA" #Insert Path to your extracted data
file_pattern = r"StreamingHistory_music_\d+\.json"      #Don't touch this, but it searches for files related to your music streaming history
files = find_files(directory_to_search, file_pattern)
convert_csv(files, "music_output.csv")

file_pattern = r"StreamingHistory_podcast_\d+\.json"    #Similar to above, but for your podcasts
files = find_files(directory_to_search, file_pattern)
convert_csv(files, "podcast_output.csv")