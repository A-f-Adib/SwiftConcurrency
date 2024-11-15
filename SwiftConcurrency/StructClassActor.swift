//
//  StructClassActor.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 16/11/24.
//

import SwiftUI


struct MyStruct {
    var title : String
}

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

struct StructClassActor: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


extension StructClassActor {
    
    private func structTest() {
        let objectA = MyStruct(title: "Starting Title")
        print("ObjectA : ", objectA.title)
        
        print("Pass the value of objectA to objectB ")
        var objectB = objectA
        print("ObjectB :", objectB.title)
        
        objectB.title = "Second Tilte"
        print("ObjectB title changed")
        
        print("ObjectA : ", objectA.title)
        print("ObjectB : ", objectB.title)
        
        /*
        OutPut:
                ObjectA : Statring Title
                ObjectB : Starting Title
                ObjectB title changed
                ObjectA : Starting Title
                ObjectB : Second Title
        */
    }
    
    
    private func classTest() {
        
        let objectA = MyClass(title: "Starting Title")
        print("ObjectA : ", objectA.title)
        
        print("Pass the value of objectA to objectB ")
        let objectB = objectA
        print("ObjectB :", objectB.title)
        
        objectB.title = "Second Tilte"
        print("ObjectB title changed")
        
        print("ObjectA : ", objectA.title)
        print("ObjectB : ", objectB.title)
        
        /*
        OutPut:
                ObjectA : Statring Title
                ObjectB : Starting Title
                ObjectB title changed
                ObjectA : Second Title
                ObjectB : Second Title
        */
    }
}

#Preview {
    StructClassActor()
}
