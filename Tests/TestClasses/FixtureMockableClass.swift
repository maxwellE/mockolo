import MockoloFramework


let klass =
"""
/// \(String.mockAnnotation)
public class Low: Mid {

    var name: String = "k2"

    required init(arg: String) {
        super.init(orderId: 1)
        self.name = arg
    }

    override init(orderId: Int) {
        super.init(orderId: orderId)
    }

    init(i: Int) {
        super.init(orderId: i)
    }

    convenience init(d: Double) {
        self.init(i: 1)
    }

    override var what: Float {
        get {
            return 3.4
        }
        set {}
    }

    override func bar() {
        
    }

    func foo() -> Int {
        return 5
    }
}

public class Mid: High {
    var what: Float = 0.0
    func bar() {}
}
"""

let klassParent =
"""
public class High {
    required init(orderId: Int) {
        self.order = orderId
    }
     init(orderId: Int, loc: String) {
        self.order = orderId
    }
    var order: Int
    func baz() -> Double { return 5.6 }
}
"""

let klassParentMock =
"""
public class HighMock: High {
    private var _doneInit = false

    required init(orderId: Int) {
        super.init(orderId: orderId)
        _doneInit = true
    }

    override init(orderId: Int, loc: String) {
        super.init(orderId: orderId, loc: loc)
        _doneInit = true
    }

    var orderSetCallCount = 0
    var underlyingOrder: Int = 0
    override var order: Int {
        get { return underlyingOrder }
        set {
            underlyingOrder = newValue
            if _doneInit { orderSetCallCount += 1 }
        }
    }

    var bazCallCount = 0
    var bazHandler: (() -> (Double))?
    override func baz() -> Double {
        bazCallCount += 1
    
        if let bazHandler = bazHandler {
            return bazHandler()
        }
        return 0.0
    }
}

"""

let klassMock =
"""
public class LowMock: Low {
    
    private var _doneInit = false
    
    
    public init(name: String = "", what: Float = 0.0) {
        self.name = name
        self.what = what
        _doneInit = true
    }
    
    var nameSetCallCount = 0
    var underlyingName: String = ""
    override var name: String {
        get { return underlyingName }
        set {
            underlyingName = newValue
            if _doneInit { nameSetCallCount += 1 }
        }
    }
    required init(arg: String = "") {
        super.init(arg: arg)
        _doneInit = true
    }
    override init(orderId: Int = 0) {
        super.init(orderId: orderId)
        _doneInit = true
    }
    override init(i: Int = 0) {
        super.init(i: i)
        _doneInit = true
    }
    
    var whatSetCallCount = 0
    var underlyingWhat: Float = 0.0
    override var what: Float {
        get { return underlyingWhat }
        set {
            underlyingWhat = newValue
            if _doneInit { whatSetCallCount += 1 }
        }
    }
    var barCallCount = 0
    var barHandler: (() -> ())?
    override func bar()  {
        barCallCount += 1
        
        if let barHandler = barHandler {
            barHandler()
        }
        
    }
    var fooCallCount = 0
    var fooHandler: (() -> (Int))?
    override func foo() -> Int {
        fooCallCount += 1
        
        if let fooHandler = fooHandler {
            return fooHandler()
        }
        return 0
    }
}
"""

let klassLongerMock =
"""
public class LowMock: Low {
    
    private var _doneInit = false
    
    
    public init(name: String = "", what: Float = 0.0, order: Int = 0) {
        self.name = name
        self.what = what
        self.order = order
        _doneInit = true
    }
    
    var nameSetCallCount = 0
    var underlyingName: String = ""
    override var name: String {
        get { return underlyingName }
        set {
            underlyingName = newValue
            if _doneInit { nameSetCallCount += 1 }
        }
    }
    required init(arg: String = "") {
        super.init(arg: arg)
        _doneInit = true
    }
    
    
    required init(orderId: Int) {
        super.init(orderId: orderId)
        _doneInit = true
    }
    override init(i: Int = 0) {
        super.init(i: i)
        _doneInit = true
    }
    
    
    var orderSetCallCount = 0
    
    var underlyingOrder: Int = 0
    
    var whatSetCallCount = 0
    var underlyingWhat: Float = 0.0
    override var what: Float {
        get { return underlyingWhat }
        set {
            underlyingWhat = newValue
            if _doneInit { whatSetCallCount += 1 }
        }
    }
    
    override var order: Int {
        get { return underlyingOrder }
        set {
            underlyingOrder = newValue
            if _doneInit { orderSetCallCount += 1 }
        }
    }
    var barCallCount = 0
    var barHandler: (() -> ())?
    override func bar()  {
        barCallCount += 1
        
        if let barHandler = barHandler {
            barHandler()
        }
        
    }
    var fooCallCount = 0
    var fooHandler: (() -> (Int))?
    override func foo() -> Int {
        fooCallCount += 1
        
        if let fooHandler = fooHandler {
            return fooHandler()
        }
        return 0
    }
    
    
    var bazCallCount = 0
    
    var bazHandler: (() -> (Double))?
    
    override func baz() -> Double {
        bazCallCount += 1
        
        if let bazHandler = bazHandler {
            return bazHandler()
        }
        return 0.0
    }
}
"""
