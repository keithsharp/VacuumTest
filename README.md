# Vacuum Test
Built and tested using Xcode 15.4, macOS 14.5, and iOS 17.5 (simulator).

This is a pair of apps I put together quickly to test an [idea](https://hachyderm.io/@groue/112524440062602440) posted by [Gwendal Roué](https://hachyderm.io/@groue).

The idea is that I want to create a macOS app that allows me to prepare data in the form of a SwiftData database that I can then include in bundle of the iOS app that I plan to distribute on the AppStore.  [Paul Hudson noted how to do this](https://www.hackingwithswift.com/quick-start/swiftdata/how-to-pre-populate-an-app-with-an-existing-swiftdata-database), and that because SwiftData uses Write Ahead Logging (WAL) you need to use Core Data in your macOS app to prepare your database.  However, this painful due to the challenges in using complex Swift types like structs, enums, and collections, in a Core Data database that will then be used in SwiftData.

**With this setup you can stay in SwiftData in both the macOS app used for creating data and the iOS app that consumes the data!  The downside is you need to perform a simple command line step to convert the database.**

# Instructions
1. Clone the repo and then open in Xcode.
2. Make sure you set the product to the macOS app **CreateData**.
3. Build and run **CreateData**.
4. Use the **Add** button to add some challenges.
5. Use the menu *File -> Export* (or &#8984;-e) to export your challenges
6. In the file open panel select the directory where you want to create the export datastore, I use `<PATH TO REPO>/exports/`.
7. Switch to a terminal and open the datastore with `sqlite3`:
```sh
cd <PATH TO REPO/exports/>
sqlite3 ./challenges.store
```
1. Then run the `vacuum` command to create a new file, note you'll need to delete the output file if it already exists:
```
vacuum into '../VacuumTest/Data/challenges.store';
```
1. You can now quit `sqlite3` and exit your terminal.
2.  Switching back to Xcode, change the product to the iOS app **VacuumTest**.
3.  Assuming you used the same paths as I did, the newly created datastore should be part of the bundle.  If not you'll need to add the file to the project (and delete the file I provided as part of the repo).
4.  Build and run **VacuumTest**.
5.  In theory, you should see the same list of challenges in **VacuumTest** in the iOS simulator as you created in **CreateData** on macOS.

# Copyright and License
Copyright 2024, Keith Sharp &lt;[kms@passback.co.uk](mailto:kms@passback.co.uk)&gt;.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.