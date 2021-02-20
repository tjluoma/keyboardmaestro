# Purpose

Backup the 'ProfilesV2' folder within the 'Application Support' folder for Stream Deck whenever the app quits.

This script is intended to be used with Keyboard Maestro as an'Execute Shell Script' with 'display results in a window' enabled. There will no no 'results' unless an error occurs.

This script exists because there is no way, that I know of, to automaticallyback up your profiles. Automatic backups are the best backups because you do not have to think about them.

While this script is not a perfect substitute for backing up your profilesmanually, it does seek to provide a 'safety net' if something bad happens to your Stream Deck setup / profiles between manual backups.

Script is provided free of charge but with no warranty expressed or implied.

If you do not use Keyboard Maestro (you should!) you can also call the script `backup-streamdeck-profiles.sh` manually, or via `launchd` (i.e. backup every night at midnight)

