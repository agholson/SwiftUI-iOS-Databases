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
        
        // Reference our games collection
        let gamesCollection = db.collection("games")
        
        // Udpate one of the documents
        gamesCollection.document("Super Mario World").setData([
            "platform": "SNES",
            "rating": "E",
            "year": "1990"
        ], merge: true
        )
        
        let snes = db.collection("consoles").document("snes")
        
        snes.updateData(["name": "Super NES", "units": "49 million"])
        
        // Reference our document
//        let reservation = db.collection("reservations").document("test123")
        
        // Modify only the people field with the following flag
//        reservation.setData(
//            ["people": 24],
//            merge: true
//        )
        
//        reservation.updateData(["people": 25])
        
//        let reservationsCollection = db.collection("reservations")
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
