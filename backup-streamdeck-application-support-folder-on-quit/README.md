
Whenever you quit the Stream Deck application, this macro will back up the "$HOME/Library/Application Support/com.elgato.StreamDeck" folder _and_ the "$HOME/Library/Preferences/com.elgato.StreamDeck.plist" preferences file. The backups are placed in "$HOME/Library/Application Support/" and will be named like this:

- 2020-09-28--01.23.51.com.elgato.StreamDeck.plist
- 2020-09-28--01.23.51.com.elgato.StreamDeck.tar.bz2

That way if something _does_ go wrong, you can try to restore those files to a particular point in time.

Note: obviously, over time these files will build up and need to be deleted, but each one is very small, so this is left as an exercise for the reader.
