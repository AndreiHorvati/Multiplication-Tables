import SwiftUI

struct SettingsGUI: View {
    @State private var _gameEngine: GameEngine
    @State private var showSettingsAlert = false
    @State private var startButtonScaleAmount: CGFloat = 1
    
    init(gameEngine: GameEngine) {
        _gameEngine = gameEngine
    }
    
    var body: some View {
        ZStack {
            Color.background
            
            VStack(spacing: 110) {
                Spacer()
                
                VStack(spacing: 30) {
                    Text("Select your number:")
                        .titleModifier()
                    
                    VStack(spacing: 15) {
                        Row(range: 2 ..< 5, gameEngine: _gameEngine)
                        
                        Row(range: 5 ..< 8, gameEngine: _gameEngine)
                        
                        Row(range: 8 ..< 11, gameEngine: _gameEngine)
                    }
                }
                
                VStack {
                    Text("Select the number of questions:")
                        .fixedSize(horizontal: false, vertical: true)
                        .titleModifier()
                    
                    HStack {
                        Spacer()
                        Spacer()
                        
                        Picker("", selection: $_gameEngine.numberOfQuestionsIndex) {
                            ForEach(0 ..< 3) { index in
                                Text(index == 2 ? "All" : String(GameEngine.numberOfQuestionsSelection[index]))
                                    .font(.title)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Spacer()
                        Spacer()
                    }
                }
                
                Button("Start Game", action: startGameUI)
                    .mainButtonModifier(scaleAmount: startButtonScaleAmount)
                
                Spacer()
            }
            .padding(.top, 30)
        }
        .alert(isPresented: $showSettingsAlert) {
            Alert(title: Text("Settings Error"), message: Text("You must choose a number from above!"))
        }
    }
    
    func startGameUI() {
        withAnimation(.easeInOut
                        .repeatCount(2, autoreverses: true)) {
            startButtonScaleAmount = 1.2
        }
        
        withAnimation(.easeInOut(duration: 0.7)) {
            startButtonScaleAmount = 1
        }
        
        withAnimation {
            do {
                try _gameEngine.startGame()
            } catch(GameErrors.NilBaseNumber) {
                showSettingsAlert = true
            } catch {
            }
        }
    }
}
