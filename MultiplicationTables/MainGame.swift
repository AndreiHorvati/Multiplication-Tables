import SwiftUI

struct MainGame: View {
    @ObservedObject private var _gameEngine = GameEngine()
    
    @State private var stringAnswer = ""
    @State private var nextQuestionButtonScaleAmount: CGFloat = 1
    
    init(gameEngine: GameEngine) {
        _gameEngine = gameEngine
    }
    
    var body: some View {
        ZStack {
            Color.background
            
            VStack {
                VStack(spacing: 10) {
                    Text("Score: \(_gameEngine.score)")
                        .titleModifier()
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    
                    Text("Question: \(_gameEngine.currentQustion)/\(_gameEngine.numberOfQuestions)")
                        .foregroundColor(.black)
                        .font(.title)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    Spacer(minLength: 20)
                    
                    HStack {
                        Spacer(minLength: 40)
                        
                        Text(_gameEngine.questions[_gameEngine.currentQustion - 1].text)
                            .fontWeight(.semibold)
                        TextField("", text: $stringAnswer, onCommit: nextQuestionUI)
                    }
                    .font(Font.custom("", size: 35))
                    .background(Color.green)
                    .cornerRadius(25)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 3))
                    .shadow(color: .black, radius: 40)
                    
                    Spacer(minLength: 10)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                VStack(spacing: 25) {
                    if _gameEngine.currentQustion < _gameEngine.numberOfQuestions {
                        Button("Next Question", action: nextQuestionUI)
                            .mainButtonModifier(scaleAmount: nextQuestionButtonScaleAmount)
                    }
                    
                    Button("Back", action: resetGameUI)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 4))
                }
            }
        }
    }
    
    func resetGameUI() {
        withAnimation {
            _gameEngine.resetGameBack()
        }
    }
    
    func nextQuestionUI() {
        withAnimation(.easeInOut
                        .repeatCount(2, autoreverses: true)) {
            nextQuestionButtonScaleAmount = 1.2
        }
        
        withAnimation(.easeInOut(duration: 0.7)) {
            nextQuestionButtonScaleAmount = 1
        }
        
        withAnimation(.easeInOut) {
            _gameEngine.verifyAnswer(answer: Int(stringAnswer) ?? -1)
            _gameEngine.nextQuestion()
            stringAnswer = ""
        }
    }
}
