struct Question {
    private var _baseNumber: Int
    private var _secondNumber: Int
    private var _positionOfTheBaseNumber: Bool
    private var _answer: Int
    
    init(baseNumber: Int, secondNumber: Int, positionOfTheBaseNumber: Bool) {
        _baseNumber = baseNumber
        _secondNumber = secondNumber
        _positionOfTheBaseNumber = positionOfTheBaseNumber
        
        _answer = _baseNumber * secondNumber
    }
    
    static func generateQuestion(baseNumber: Int) -> Question {
        Question(baseNumber: baseNumber, secondNumber: Int.random(in: 1 ..< 11), positionOfTheBaseNumber: Bool.random())
    }
    
    var answer: Int {
        get {
            _answer
        }
    }
    
    var baseNumber: Int {
        get {
            _baseNumber
        }
    }
    
    var secondNumber: Int {
        get {
            _secondNumber
        }
    }
    
    var positionOfTheBaseNumber: Bool {
        get {
            _positionOfTheBaseNumber
        }
    }
    
    var text: String {
        !_positionOfTheBaseNumber ? "\(baseNumber) x \(secondNumber) =" : "\(secondNumber) x \(baseNumber) ="
    }
}
