# Firebase SwiftUIDemo app
This app demonstrates how to use Firebase in a SwiftUI iOS app.

# Firebase Setup
1) Go to firebase.com
1) Click new project.
  - Copy app bundle identifier from the top-left file in Xcode.
1) Create a new iOS app.
1) Paste app bundle identifier as well as give it a name.

## Pods Setup
1) Open a terminal window in your project's root.
1) Type `pod init`
1) Click through the steps to add Firebase to your project.
1) Choose the Firebase libraries you want to use to setup the project.
  - Go to: https://firebase.google.com/docs/ios/setup#available-pods
1) Open with a text editor the new pod file.
  - `vim Podfile`
1) Install the selected libraries
  - `pod install`
  - Note: if you need to remove pods, then you do that through `pod install` as well after deleting
  the library from the `Podfile`

# Database Setup
In Firebase, there are two databases available:
1) Firestore
2) Realtime

The Firestore database is the latest available database, so we recommend this one, because it builds
on lessons learned from the older Realtime database. See
 [here](https://firebase.google.com/docs/database/rtdb-vs-firestore) for more details on the two.

You create the database in the top-left setting of the Firebase console under `Build -> Firestore Database`

When you first create the database, you get to choose a location. Note that you cannot change this location
once you create your app. Therefore, choose the location that most closely will serve your users. You can
see all of the available [locations here](https://cloud.google.com/firestore/docs/locations)

If you want a database, which goes global, then you should check out [FaunaDB](www.fauna.com).


