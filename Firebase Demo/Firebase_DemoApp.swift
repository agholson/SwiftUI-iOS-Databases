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
    }
    
    func makeReservation() {
        
        // Reference the Cloud Firestore database
        let db = Firestore.firestore()
        
        let reservationsCollection = db.collection("reservations")
        
        let reservation = reservationsCollection.addDocument(data: ["name": "Steve", "people": 4 ])
        reservationsCollection.addDocument(data: ["name": "Cathy", "people": 8])
        
        // Delete a field from a document
        reservation.updateData(["people": FieldValue.delete()])
        
        // Delete a document
        reservation.delete()
        
        // Error Handling
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
        
        // Delete the genre/ platformer key pair
        let superMarioDocument = db.collection("games").document("Super Mario World")
        
        superMarioDocument.updateData(["genre": FieldValue.delete()])
        
        let snesDocument = db.collection("consoles").document("snes")
        
        snesDocument.delete()
        
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
