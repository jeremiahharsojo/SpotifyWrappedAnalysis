# SpotifyWrappedAnalysis
Converts json files from Spotify's user data download into an SQLite compatible .csv

IMPORTANT:

The source code includes my raw data and .csv outputs, you can use this to verify that python and sqlite works on your machine.

Please delete the .csv and RAW DATA folder before running the program, to minimize the risk of my data bleeding into yours

DO NOT FORGET TO ADD THE PATH TO YOUR SPOTIFY DATA IN "processor.py".

I can't tell you how to do this (I made this code in Windows) so please find how to do this yourself.

I CANNOT GUARANTEE THIS WORKS ON MACOS.

REQUIRED:
pandas and numpy python packages;
SQLite Installed and added to PATH on Windows


STEPS:
Get your data from https://www.spotify.com/us/account/privacy/
    
      NOTE: request the account data from the previous year (DOESN'T WORK WITH EXTENDED)
      
Add your extract path to the processor.py file

Run the python file to get a .csv of your data

    py processor.py

Specify the date range you want in the SQL file (modify start and end variable)

Run sqlite initialized with server.sql

    sqlite3 -init server.sql

NOTE:

Downloading your Spotify data comes with a lot of identifying information, 
please sanitize this if you're going to share your source code. 

However, it's interesting to see what they have on you (they had my phone number from 5+ years ago).

Please read the .sql and.py source code if you're interested in how it works. 

Also, the extended data download spotify has that includes all your listening data won't work with this source code.
I might fix this when I revisit this in the future. 
