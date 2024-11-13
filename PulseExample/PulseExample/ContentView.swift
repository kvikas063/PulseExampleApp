//
//  ContentView.swift
//  PulseExample
//
//  Created by Vikas Kumar on 12/11/24.
//

import SwiftUI
import PulseUI

struct ContentView: View {
    @State private var apiStatus: Bool = false
    @State private var showConsole: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button {
                Task {
                    await NetworkManager.shared.getUsers()
                }
            } label: {
                Text("Call another API")
            }
            .padding(.top, 40)

            Button {
                showConsole.toggle()
            } label: {
                Text("Open Pulse Console")
            }
            .padding(.top, 40)

        }
        .padding()
        .sheet(isPresented: $showConsole) {
            NavigationView {
                ConsoleView()
                    .navigationTitle("Console")
            }
        }
        .task {
            let response = await NetworkManager.shared.getData()
            switch response {
                case .success(let success):
                    debugPrint(success)
                    apiStatus = true
                case .failure(let failure):
                    debugPrint(failure.localizedDescription)
                    apiStatus = false
            }
        }
    }
}

#Preview {
    ContentView()
}
