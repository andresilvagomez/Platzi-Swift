import Foundation

struct Acccount {
    var amounth: Float = 0
    var name: String = ""
    var transactions: [Float] = []
    
    init(amounth: Float, name: String) {
        self.amounth = amounth
        self.name = name
    }
    
    @discardableResult
    mutating func addTransaction(value: Float) -> Float {
        if (amounth - value) < 0 {
            return 0
        }
        
        amounth -= value
        transactions.append(value)
        
        return amounth
    }
}

struct Person {
    var name: String
    var lastName: String
    var account: Acccount?
}

var me = Person(name: "Andres", lastName: "Silva", account: nil)

let account = Acccount(amounth: 100_000, name: "X bank")

me.account = account

print(me.account!)

me.account?.addTransaction(value: 20)

print(me.account!)


