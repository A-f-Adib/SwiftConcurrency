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
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

struct StructClassActor: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StructClassActor()
}
