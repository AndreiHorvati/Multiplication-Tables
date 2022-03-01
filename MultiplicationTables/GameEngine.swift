import Foundation

enum GameErrors: Error {
    case NilBaseNumber
}

class GameEngine: ObservableObject {
    private var _questions = [Question]()
    private var _numberOfQuestionsIndex = 1
    @Published private var _isGameEnabled = false
    @Published private var _baseNumberIndex: Int? = nil
    @Published private var _currentQuestion: Int! = nil    
    @Published private var _score = 0
    
    static private var _numberOfQuestionsSelection = [5, 7, 10]
    
    static var numberOfQuestionsSelection: [Int] {
        get {
            _numberOfQuestionsSelection
        }
    }
    
    var numberOfQuestions: Int {
        get {
            GameEngine._numberOfQuestionsSelection[_numberOfQuestionsIndex]
        }
    }
    
    var score: Int {
        get {
            _score
        }
        
        set(newScore) {
            _score = newScore
        }
    }
    
    var currentQustion: Int {
        get {
            _currentQuestion
        }
        
        set(newQuestion) {
            _currentQuestion = newQuestion
        }
    }
    
    var isGameEnable: Bool {
        get {
            _isGameEnabled
        }
        
        set {
            _isGameEnabled = newValue
        }
    }
    
    var baseNumberIndex: Int? {
        get {
            _baseNumberIndex
        }
        
        set(newBaseNumberIndex) {
            _baseNumberIndex = newBaseNumberIndex
        }
    }
    
    var numberOfQuestionsIndex: Int {
        get {
            _numberOfQuestionsIndex
        }
        
        set(newNumber) {
            _numberOfQuestionsIndex = newNumber
        }
    }
    
    var questions: [Question] {
        get {
            _questions
        }
    }
    
    func createQuestions() throws {
        guard let baseNumberIndex = baseNumberIndex else {
            throw GameErrors.NilBaseNumber
        }
        
        _questions = [Question]()
        var isUsed = [Bool](repeating: false, count: 10)
        
        for _ in 0 ..< GameEngine.numberOfQuestionsSelection[numberOfQuestionsIndex] {
            var newQuestion: Question! = nil
            
            repeat {
                newQuestion = Question.generateQuestion(baseNumber: baseNumberIndex)
            } while(isUsed[newQuestion.secondNumber - 1])
            
            _questions.append(newQuestion)
            isUsed[newQuestion.secondNumber - 1] = true
        }
    }
    
    func startGame() throws {
        do {
            try createQuestions()
            _isGameEnabled = true
            _currentQuestion = 1
        } catch(GameErrors.NilBaseNumber) {
            throw GameErrors.NilBaseNumber
        } catch {
        }
    }
    
    func verifyAnswer(answer: Int) {
        if answer == questions[currentQustion - 1].answer {
            score += 1
        }
    }
    
    func nextQuestion() {
        if currentQustion < numberOfQuestions {
            currentQustion += 1
        }
    }
    
    func resetGameBack() {
        _isGameEnabled = false
        _currentQuestion = 1
        _score = 0
    }
}
