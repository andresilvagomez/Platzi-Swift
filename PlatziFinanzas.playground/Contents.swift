import Foundation

protocol Transaction {
    var value: Float { get }
    var name: String { get }
    var isValid: Bool { get }
    
    func invalidateTrantraction()
}

enum DebitCategories: Int {
    case health
    case food, rent, tax, transportation
    case entertainment = 10
}

enum TransactionType {
    case debit(value: Float, name: String, category: DebitCategories)
    case gain(value: Float, name: String)
}

class Debit: Transaction {
    var value: Float
    var name: String
    var category: DebitCategories
    var isValid: Bool = true

    init(value: Float, name: String, category: DebitCategories) {
        self.category = category
        self.value = value
        self.name = name
    }
    
    func invalidateTrantraction() {
        isValid = false
    }
}

class Gain: Transaction {
    var value: Float
    var name: String
    var isValid: Bool = true
    
    init(value: Float, name: String) {
        self.value = value
        self.name = name
    }
    
    func invalidateTrantraction() {
        isValid = false
    }
}

class Acccount {
    var amount: Float = 0 {
        willSet {
            print("Vamos a cambiar el valor", amount, newValue)
        }
        didSet {
            print("Tenemos nuevo valor", amount)
        }
    }
    
    var name: String = ""
    var transactions: [Transaction] = []
    
    var debits: [Debit] = []
    var gains: [Gain] = []
    
    init(amount: Float, name: String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    func addTransaction(transaction: TransactionType) -> Float {
        switch transaction {
        case .debit(let value, let name, let category):
            if (amount - value) < 0 {
                return 0
            }
            
            let debit = Debit(value: value, name: name, category: category)
            
            amount -= debit.value
            
            transactions.append(debit)
            debits.append(debit)
        case .gain(let value, let name):
            let gain = Gain(value: value, name: name)
            amount += gain.value
            transactions.append(gain)
            gains.append(gain)
        }
        
        return amount
    }
    
    func transactionsFor(category: DebitCategories) -> [Transaction] {
        return transactions.filter({ (transaction) -> Bool in
            guard let transaction = transaction as? Debit else {
                return false
            }
            
            return transaction.category == category
        })
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

let account = Acccount(amount: 100_000, name: "X bank")

me.account = account

print(me.account!)

me.account?.addTransaction(
    transaction: .debit(
        value: 20,
        name: "Cafe con amigos",
        category: DebitCategories.food
    )
)

me.account?.addTransaction(
    transaction: .debit(
        value: 100,
        name: "Juego PS4",
        category: .entertainment
    )
)

me.account?.addTransaction(
    transaction: .debit(
        value: 500,
        name: "PS4",
        category: .entertainment
    )
)

me.account?.addTransaction(
    transaction: .gain(value: 1000, name: "Salario")
)

print(me.account!.amount)

let transactions = me.account?.transactionsFor(category: .entertainment) as? [Debit]
for transaction in transactions ?? [] {
    print(
        transaction.name,
        transaction.value,
        transaction.category.rawValue
    )
}



