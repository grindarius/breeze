# Breeze
A habit tracker app made from Flutter to track your progress and keep you on track.

# Disclaimer
This application is still buggy when running on Pixel 5 Emulator. I suggest the user to run this application on web compiler, I am still loooking into the problem.

## Functionalities
- [x] Create, edit and delete defined habit.
- [x] Display statistics about how consistent your habit is.
- [ ] Able to give notifications to do the habit with quick replies.

# Running the application
Preferrably to run the command below in `bash` shell since there's `bash` scripts to run. If you don't have `bash` shell, you can copy the scripts in the file and run them individually. Those files are there just for convenience since Dart and Flutter does not have script systems like what `npm` had yet.  

```
flutter pub get
```
to get essential packages.

```
sh scripts/generate_hivetype.sh
```
to generate `Hive`'s type helper files.

```
flutter run
```
to run the application.

# References
- https://github.com/cybdom/flutter-habit-tracker for UI inspiration.
- https://uxdesign.cc/dark-mode-ui-design-the-definitive-guide-part-1-color-53dcfaea5129 for dark mode guides.
- https://stackoverflow.com/a/67137405/12386405 for instructions on creating app icons.
- https://youtu.be/YXDFlpdpp3g for pretty cool routing guides
- https://loophabits.org/ for main UI that I am going to use.
- https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates for finding days between 2 dates.
