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


