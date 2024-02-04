//
//  ContentView.swift
//  SwiftUI-Basic
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            VStack{ // 수직
                ImageView()
                ButtonView()
                TextView()
            }
            HStack{ // 수평
                ImageView()
                ButtonView()
                TextView()
            }
            ZStack{ // 콘텐츠 위에 콘텐츠
                ImageView()
                ButtonView()
                TextView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
