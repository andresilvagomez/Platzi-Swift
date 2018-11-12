import Foundation

class Acccount {
    var amounth: Float = 0 {
        willSet {
            print("Vamos a cambiar el valor", amounth, newValue)
        }
        didSet {
            print("Tenemos nuevo valor", amounth)
        }
    }
    
    var name: String = ""
    var transactions: [Float] = []
    
    init(amounth: Float, name: String) {
        self.amounth = amounth
        self.name = name
    }
    
    @discardableResult
    func addTransaction(value: Float) -> Float {
        if (amounth - value) < 0 {
            return 0
        }
        
        amounth -= value
        transactions.append(value)
        
        return amounth
    }
}

class Person {
    var name: String = ""
    var lastName: String = ""
    var account: Acccount?
    
    var fullName: String {
        get {
            return "\(name) \(lastName)"
        }
        set {
            name = String(newValue.split(separator: " ").first ?? "")
            lastName = "\(newValue.split(separator: " ").last ?? "")"
        }
    }
    
    init(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
    }
}

var me = Person(name: "Andres", lastName: "Silva")

let account = Acccount(amounth: 100_000, name: "X bank")

me.account = account

print(me.account!)

account.addTransaction(value: 20)
me.account?.addTransaction(value: 20)

print(me.account!.amounth)

print(me.fullName)

me.fullName = "Pedro Perez"

print(me.lastName)
print(me.name)

