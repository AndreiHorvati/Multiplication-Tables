//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Andrei Horvati on 06.09.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var _gameEngine = GameEngine()
    
    var body: some View {
        if !_gameEngine.isGameEnable {
            SettingsGUI(gameEngine: _gameEngine)
                .transition(.opacity)
        } else {
            MainGame(gameEngine: _gameEngine)
                .transition(.opacity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
