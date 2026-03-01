# 📝 Flutter Web + SQLite Practice
Just a playground project to figure out how SQLite works on the Web using Flutter. The goal was to stop just printing to the console and actually build a functional UI that saves data.

## 🛠 What I learned

Async/Await: Databases take time to respond. I learned to use await so the app doesn't try to read data before the file is even open.

State Management: Using setState() to tell Flutter "Hey, I added a task, refresh the list!"

## 🏗 How it's built
1. The "Brain" (DatabaseHelper)
Instead of putting SQL code everywhere, I put it all in one class.

Factory: It "manufactures" the web connection.

Static: There's only ever one database connection running (Singleton pattern).

Null Safety: Used ? and ! to handle cases where the database might not be initialized yet.

2. The "Face" (TaskScreen)
A StatefulWidget that actually shows the data.

initState: Loads the data as soon as the app starts.

FutureBuilder: (I used this early on, but switched to setState for more control).

ListView.builder: Efficiently creates the list of tasks so it only renders what's on screen.

## 🚀 How to run it
Make sure web/sqlite3.wasm exists.

Run flutter pub get.

Hit flutter run -d chrome.
