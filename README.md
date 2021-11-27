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

## Database Interaction
We create an instance of the Firebase database within our project. This instance automatically uses our
GoogleService-Info.plist file in order to authenticate with our Firebase app. We must initialize this 
database in the init method for our app.
```
    init() {
        FirebaseApp.configure()
        
        // Create documents below
        makeReservation()
    }
    
    func makeReservation() {
        
        // Reference the Cloud Firestore database
        let db = Firestore.firestore()
        
        // Access the reservations collection, or creates it, if not already created
        let reservations = db.collection("reservations")
        
        // Create a document with a given identifier
        reservations.document("test123").setData([
            "name": "Carol",
            "people": 22
        ])
        
        // Create document with a unique identifier
        reservations.document().setData(["name" : "Tom"])
        
        // Create document with given data, then assign it to a constant
        let document = reservations.addDocument(data: [
            "name": "Sue",
            "people": 10
        ])
        
        // Work with the document
        
        
    }
```

Access a single document in a single collection:
```
// db.collection("<collectionName>").document("<documentId")
let reservation = db.collection("reservations").document("test123")
```

Update a document without overwriting the rest of its keys. Note that if the key does not exist, then it
will create a new one.
```
// reservation.updateData("<key>": <value>)
reservation.updateData("people": 15)
```

Delete a key from a document:
```
// Create the new doument
let reservation = reservationsCollection.addDocument(data: ["name": "Steve", "people": 4 ])
reservationsCollection.addDocument(data: ["name": "Cathy", "people": 8])

// Delete a field from a document
reservation.updateData(["people": FieldValue.delete()])

// Delete a document
reservation.delete()
```

## Error Handling
For any call to the Firestore database, we can add a completion handler to take care of the error.

```
reservationsCollection.addDocument(data: [:]) { error in
    // Check if there was an error
    if let error = error { // Only exists, if error exists
        print(error.localizedDescription)
    }
    // Call succeeded
    else {
        return
    }
}
```
