import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        self = calendar.date(from: dateComponents) ?? Date()
    }
}

protocol InvalidateTransaction {
    func invalidateTrantraction(transaction: Transaction)
}

protocol Transaction {
    var value: Float { get }
    var name: String { get }
    var isValid: Bool { get set }
    var delegate: InvalidateTransaction? { get set }
    var date: Date { get }
}

extension Transaction {
    mutating func invalidateTrantraction() {
        isValid = false
        delegate?.invalidateTrantraction(transaction: self)
    }
}

protocol TransactionDebit: Transaction {
    var category: DebitCategories { get }
}

enum DebitCategories: Int {
    case health
    case food, rent, tax, transportation
    case entertainment = 10
}

enum TransactionType {
    case debit(value: Float, name: String, category: DebitCategories, date: Date)
    case gain(value: Float, name: String, date: Date)
}

class Debit: TransactionDebit {
    var date: Date
    var delegate: InvalidateTransaction?
    var value: Float
    var name: String
    var category: DebitCategories
    var isValid: Bool = true

    init(value: Float, name: String, category: DebitCategories, date: Date) {
        self.category = category
        self.value = value
        self.name = name
        self.date = date
    }
}

class Gain: Transaction {
    var date: Date
    var delegate: InvalidateTransaction?
    var value: Float
    var name: String
    var isValid: Bool = true
    
    init(value: Float, name: String, date: Date) {
        self.value = value
        self.name = name
        self.date = date
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
    func addTransaction(transaction: TransactionType) -> Transaction? {
        switch transaction {
        case .debit(let value, let name, let category, let date):
            if (amount - value) < 0 {
                return nil
            }
            
            let debit = Debit(value: value, name: name, category: category, date: date)
            debit.delegate = self
            
            amount -= debit.value
            
            transactions.append(debit)
            debits.append(debit)
            return debit
        case .gain(let value, let name, let date):
            let gain = Gain(value: value, name: name, date: date)
            gain.delegate = self
            amount += gain.value
            transactions.append(gain)
            gains.append(gain)
            return gain
        }
    }
    
    func transactionsFor(category: DebitCategories) -> [Transaction] {
        return transactions.filter({ (transaction) -> Bool in
            guard let transaction = transaction as? Debit else {
                return false
            }
            
            return transaction.isValid && transaction.category == category
        })
    }
}

extension Acccount: InvalidateTransaction {
    func invalidateTrantraction(transaction: Transaction) {
        if transaction is Debit {
            amount += transaction.value
        }
        if transaction is Gain {
            amount -= transaction.value
        }
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
        category: DebitCategories.food,
        date: Date(year: 2018, month: 11, day: 14)
    )
)

me.account?.addTransaction(
    transaction: .debit(
        value: 100,
        name: "Juego PS4",
        category: .entertainment,
        date: Date(year: 2018, month: 11, day: 10)
    )
)

me.account?.addTransaction(
    transaction: .debit(
        value: 500,
        name: "PS4",
        category: .entertainment,
        date: Date(year: 2018, month: 11, day: 10)
    )
)

me.account?.addTransaction(
    transaction: .gain(
        value: 1000,
        name: "Salario",
        date: Date(year: 2018, month: 11, day: 1)
    )
)

var salary = me.account?.addTransaction(
    transaction: .gain(
        value: 1000,
        name: "Salario",
        date: Date(year: 2018, month: 11, day: 1)
    )
)

salary?.invalidateTrantraction()

print(me.account!.amount)

let transactions = me.account?.transactionsFor(category: .entertainment) as? [Debit]
for transaction in transactions ?? [] {
    print(
        transaction.name,
        transaction.value,
        transaction.category.rawValue,
        transaction.date
    )
}

for gain in me.account?.gains ?? [] {
    print(
        gain.name,
        gain.isValid,
        gain.value,
        gain.date
    )
}

print(me.account?.amount ?? 0)

