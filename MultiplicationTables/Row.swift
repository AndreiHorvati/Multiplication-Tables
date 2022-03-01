import SwiftUI

struct NumberButton: View {
    @ObservedObject private var _gameEngine: GameEngine
    
    private var _number: Int
    
    init(number: Int, gameEngine: GameEngine) {
        _number = number
        _gameEngine = gameEngine
    }
    
    var isBaseNumber: Bool {
        guard let baseNumber = _gameEngine.baseNumberIndex else {
            return false
        }
        
        return baseNumber == _number
    }
    
    var body: some View {
        Button("\(_number)") {
            withAnimation {
                if !isBaseNumber {
                    _gameEngine.baseNumberIndex = _number
                } else {
                    _gameEngine.baseNumberIndex = nil
                }
            }
        }
        .padding(30)
        .frame(width: 105, height: 45)
        .background(Color.backGroundColors.randomElement())
        .foregroundColor(.black)
        .font(.title)
        .cornerRadius(25)
        .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(isBaseNumber ? Color.green : .black, lineWidth: 4))
        .shadow(color: .black, radius: 10)
        .scaleEffect(isBaseNumber ? 1.1 : 1.0)
    }
}

struct Row: View {
    @State private var _gameEngine: GameEngine
    
    private var _range: Range<Int>
    
    init(range: Range<Int>, gameEngine: GameEngine) {
        _range = range
        _gameEngine = gameEngine
    }
    
    var body: some View {
        HStack(spacing: 17) {
            ForEach(_range) { number in
                NumberButton(number: number, gameEngine: _gameEngine)
            }
        }
    }
}
