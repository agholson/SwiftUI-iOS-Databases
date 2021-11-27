# Firebase SwiftUIDemo app
This app demonstrates how to use Firebase in a SwiftUI iOS app. It is based on the excellent [Code with Chris](https://codewithchris.com) 
iOS Databases module 1 course.

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

## Reading Data
You can get the data for a single document in the following manner.
```
// Get the data for a single document
document.getDocument { docSnapshot, error  in
    
    // Check for an error and handle it
    if let error = error {
        print(error.localizedDescription)
    }
    // Check if we received data
    else if let docSnapshot = docSnapshot {
        // Print the JSON data
        print(docSnapshot.data())
        
        // Print the doucment ID
        print(docSnapshot.documentID)
        
    }
    // Else it means no error occurred, but no data was returned
    else {
        
    }
}
```

### Reading all Documents in Collection
It is possible to download all of the documents in one go. Or, you can listen for changes to specific 
documents, then update those accordingly.

```
// Get all documents from a collection
reservationsCollection.getDocuments { querySnapshot, error in
    
    // Check for an error and handle it
    if let error = error {
        // Handle the error
    }
    // Else we see if we could get a querySnapshot
    else if let querySnapshot = querySnapshot {
        
        // Parse the returned documents
        for doc in querySnapshot.documents {
            // Print all the document IDs
            print(doc.documentID)
        }
        
    }
    // Else no data was returned
    else {

    }
    
}
```

### Listening for Database Changes
With Firebase, we can get notified, whenever there are changes to a particular document. We use a snapshot
listener in order to accomplish this.

```
// Add a snapshot listener to this document
let listener1 = document.addSnapshotListener { docSnapshot, error in
    
    // Check for any errors
    if let error = error {
        print("Error occurred on line 94: \(error)")
    }
    // Data receieved with every update to the document
    print(docSnapshot?.data() ?? "")
    
}

// MARK: Listen for any Changes to the Reservations Collection
let listner2 = reservationsCollection.addSnapshotListener { querySnapshot, error in
    
    // Handle any errors
    if let error = error {
        
    }
    // Make sure we received the documents
    else if let querySnapshot = querySnapshot {
        // Loop through only the documents changed, since the last sync
        for doc in querySnapshot.documentChanges {
            // Print the data for each one
            print(doc.document.data())
            
        }
        
    }
    
}
```

### Queries
Queries are powerful pieces of code, which allow us to tell the database what data we want back. Instead, of receiving all of the documents
in a collection, we can tell it to only send back documents with "Carol" in the "name" key, or converserly documents that do not contain 
Carol in the name.

Query to return only documents with "Dave" or "Carol" in the name field:
```
let query = reservationsCollection.whereField("name", in: ["Dave", "Carol"])
``` 

Then, you need to execute this query in order to get results:
```
// Execute the query
query.getDocuments { querySnapshot, error in
    // Make sure no errors, and the query contains data
    if error == nil && querySnapshot != nil {
        // Loop through the documents in the returned query
        for doc in querySnapshot!.documents {
            print(doc.data())
        }
    }
}
```

We could also create a query to not get documents with two names in them, using `notIn`:
```
reservationsCollection.whereField("name", notIn: ["Dave", "Carol"])
```

You can also create a query, which will return documents with an array key, where it matches any of the values you desire:
```
// Check if a key with a list of values contains a specific value
reservationsCollection.whereField("reservationList", arrayContains: 1)
``` 

Or an array that contains any of the list of values:
```
reservationsCollection.whereField("reservationsList", arrayContainsAny: [1, 2, 3])
```
