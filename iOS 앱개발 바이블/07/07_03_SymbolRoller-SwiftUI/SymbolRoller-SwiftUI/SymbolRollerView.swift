//
//  ContentView.swift
//  SymbolRoller-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct SymbolRollerView: View {
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]
    
    // 버튼 누를때마다 바뀔 이미지 상태
    // 초기설정은 moon
    @State var imageName: String = "moon"
    
    var body: some View {
        // Vstack <- Image, Text, Button
        VStack{
            Spacer()
            
            Image(systemName: imageName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(50)
            
            Spacer()
            
            Text(imageName)
                .font(.system(size: 40, weight: .bold))
            Button{ // Hstack -> 좌 : 이미지 / 우 : Vstack
                print("Button Tapped")
                imageName = symbols.randomElement()!
            } label: {
                HStack {
                    Image(systemName: "arrow.3.trianglepath")
                    VStack {
                        Text("Reload")
                            .font(.system(size: 30, weight: .bold,design: .default))
                        Text("Click me to reload")
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(.pink)
            .foregroundColor(.white)
            .cornerRadius(40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolRollerView()
    }
}
