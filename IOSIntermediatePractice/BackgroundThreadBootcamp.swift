//
//  BackgroundThreadBootcamp.swift
//  IOSIntermediatePractice
//
//  Created by Dev C Krishna on 02/09/22.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetData() {
        DispatchQueue.global(qos: .background).async {
            let data = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = data
            }
        }
        
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetData()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
