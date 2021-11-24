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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
