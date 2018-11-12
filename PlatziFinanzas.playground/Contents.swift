import Foundation

var accountTotal: Float = 1_000_000.0

let name = "Andres"
let lastName = "Silva"

let fullName = "\(name) \(lastName)"

print(fullName.capitalized)

accountTotal += 100_000

print(accountTotal)

var isActive = !fullName.isEmpty

print(isActive)

var transactions: [Float] = [20, 10, 100.0]

print(transactions)

transactions.count
transactions.isEmpty

transactions.append(40)

print(transactions)

transactions.first
transactions.last

transactions.removeLast()

print(transactions)

transactions.min()
transactions.max()

var dailyTransaction: [[Float]] = [
    [20, 10, 100.0],
    [],
    [1000],
    [],
    [10]
]

dailyTransaction.first
dailyTransaction[4].isEmpty

var transactionsDict: [String: [Float]] = [
    "1nov": [20, 10, 100.0],
    "2nov": [],
    "3nov": [1000],
    "4nov": [],
    "5nov": [10]
]

var transactionsDict2: [String: [Float]] = [
    "2nov": [1000],
    "3nov": [1000],
    "4nov": [1000],
]

func totalAccount(forTransactions transactions: [String: [Float]]) -> Float {
    var total: Float = 0
    for key in transactions.keys {
        let array = transactions[key]!
        total += array.reduce(0.0, +)
    }
    return total
}

let total = totalAccount(forTransactions: transactionsDict)
let total2 = totalAccount(forTransactions: transactionsDict2)

print(total)
print(total2)





