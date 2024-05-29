# Vacuum Test
Built and tested using Xcode 15.4, macOS 14.5, and iOS 17.5 (simulator).

This is a pair of apps I put together quickly to test an [idea](https://hachyderm.io/@groue/112524440062602440) posted by [Gwendal Roué](https://hachyderm.io/@groue).

The idea is that I want to create a macOS app that allows me to prepare data in the form of a SwiftData datastore that I can then include in bundle of the iOS app that I plan to distribute on the AppStore.  [Paul Hudson noted how to do this](https://www.hackingwithswift.com/quick-start/swiftdata/how-to-pre-populate-an-app-with-an-existing-swiftdata-database), and that because SwiftData uses Write Ahead Logging (WAL) you need to use Core Data in your macOS app to prepare your datastore.  However, this painful due to the challenges in using complex Swift types like structs, enums, and collections, in Core Data that will then be used in SwiftData.

**Unfortunately the approach doesn't seem to work,though open an issue if it's a problem in my code.  Hopefully Apple will give us a solution for this use case at WWDC24 in June.**

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
1. Then run the `vacuum` command to create a new file:
```
vacuum into '../VacuumTest/Data/challenges.store';
```
1. You can now quit `sqlite3` and exit your terminal.
2.  Switching back to Xcode, change the product to the iOS app **VacuumTest**.
3.  Assuming you used the same paths as I did, the newly created datastore should be part of the bundle.  If not you'll need to add the file to the project (and delete the file I provided as part of the repo).
4.  Build and run **VacuumTest**.
5.  In theory, you should see the same list of challenges in **VacuumTest** in the iOS simulator as you created in **CreateData** on macOS.