//
//  Firebase_DemoApp.swift
//  Firebase Demo
//
//  Created by Shepherd on 11/22/21.
//

import SwiftUI
import Firebase

@main
struct Firebase_DemoApp: App {
    
    init() {
        FirebaseApp.configure()
        
        // Create documents below
        makeReservation()
        
        // Used for challenges
//        challengeInteractions()
    }
    
    /*
     Code here handles the iOS Databases module 1 challenges
     */
    func challengeInteractions() {
        // Retrieve the nes document from the consoles collection
        let db = Firestore.firestore()
        
        // Get the nes document
        let nesDocument = db.collection("consoles").document("nes")
        
        
        // Access the data in this document
        nesDocument.getDocument { docSnapshot, error in
            
            // Check for errors
            if let error = error {
                // Log the error
                print("Error occurred in challengeInteractions() line 41. Error details: \(error.localizedDescription)")
            }
            // Check for data
            else if let docSnapshot = docSnapshot {
                // Print the data for the document
                print(docSnapshot.data())
            }
            // Else the document did not have any data
            else {
                print("Document contained no data line 49")
            }
            
        }
        
        // Get all the documents in the games collection
        let gamesDocuments = db.collection("games").getDocuments { querySnapshot, error in
            
            // Check for errors
            if let error = error {
                // Log the errors
                print("Error line 61 in challengeInteractions(). Full error: \(error)")
            }
            // Else check for the returned querySnapshots
            else if let querySnapshot = querySnapshot {
                // Loop through all the documents
                for doc in querySnapshot.documents {
                    
                    // Print the document data
                    print(doc.data())
                }
                
            }
            
        }
        
        
    }
    
    func makeReservation() {
        
        // Reference the Cloud Firestore database
        let db = Firestore.firestore()
        
        let reservationsCollection = db.collection("reservations")
    
        // Get a document reference
        let document = reservationsCollection.document("test123")
        
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
        
        // Remove the snapshot listeners
        listener1.remove()
        
//
//        // Get the data for a single document
//        document.getDocument { docSnapshot, error  in
//
//            // Check for an error and handle it
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            // Check if we received data
//            else if let docSnapshot = docSnapshot {
//                // Print the JSON data
//                print(docSnapshot.data())
//
//                // Print the doucment ID
//                print(docSnapshot.documentID)
//
//            }
//            // Else it means no error occurred, but no data was returned
//            else {
//
//            }
//        }
        
        // Get all documents from a collection
//        reservationsCollection.getDocuments { querySnapshot, error in
//
//            // Check for an error and handle it
//            if let error = error {
//                // Handle the error
//            }
//            // Else we see if we could get a querySnapshot
//            else if let querySnapshot = querySnapshot {
//
//                // Parse the returned documents
//                for doc in querySnapshot.documents {
//                    // Print all the document IDs
//                    print(doc.documentID)
//                }
//
//            }
//            // Else no data was returned
//            else {
//
//            }
//
//        }
//
//
        
//        let reservation = reservationsCollection.addDocument(data: ["name": "Steve", "people": 4 ])
//        reservationsCollection.addDocument(data: ["name": "Cathy", "people": 8])
//
//        // Delete a field from a document
//        reservation.updateData(["people": FieldValue.delete()])
//
//        // Delete a document
//        reservation.delete()
        
        // Error Handling
//        reservationsCollection.addDocument(data: [:]) { error in
//            // Check if there was an error
//            if let error = error { // Only exists, if error exists
//                print(error.localizedDescription)
//            }
//            // Call succeeded
//            else {
//                return
//            }
//        }
        
        // Delete the genre/ platformer key pair
//        let superMarioDocument = db.collection("games").document("Super Mario World")
//
//        superMarioDocument.updateData(["genre": FieldValue.delete()])
//
//        let snesDocument = db.collection("consoles").document("snes")
//
//        snesDocument.delete()
        
        // Reference our games collection
//        let gamesCollection = db.collection("games")
        
        // Udpate one of the documents
//        gamesCollection.document("Super Mario World").setData([
//            "platform": "SNES",
//            "rating": "E",
//            "year": "1990"
//        ], merge: true
//        )
//
//        let snes = db.collection("consoles").document("snes")
//
//        snes.updateData(["name": "Super NES", "units": "49 million"])
        
        // Reference our document
//        let reservation = db.collection("reservations").document("test123")
        
        // Modify only the people field with the following flag
//        reservation.setData(
//            ["people": 24],
//            merge: true
//        )
        
//        reservation.updateData(["people": 25])
        
//
//
//        // Add data with auto-generated ID
//        reservationsCollection.addDocument(data: [
//            "name": "Peter",
//            "people": 3
//        ])
//
//        // Add data with chosen ID
//        reservationsCollection.document("vip1").setData([
//            "name": "Sam",
//            "people" : 2
//        ])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
