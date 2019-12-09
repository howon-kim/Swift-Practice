//
//  ContentView.swift
//  Test
//
//  Created by Howon Kim on 6/28/19.
//  Copyright © 2019 Howon Kim. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        VStack {
            Image("IMG_7652")

            VStack {
                Text("Hello World")
                Text("I Am Here")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
