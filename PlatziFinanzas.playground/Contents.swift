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

print(transactionsDict.count)

print(accountTotal)

accountTotal -= 300_000

if accountTotal > 1_000_000 {
    print("Somos ricos")
} else if accountTotal > 0 {
    print("No tenemos tanto dinero")
} else {
    print("No tenemos nada!!")
}

let hasMoney = accountTotal > 1_000_000 ? "Somos ricos" : "No tenemos tanto dinero"

print(hasMoney)

var age = 24
var tax = 1.0

switch age {
    case 0...17:
        print("No podemos dar una tarjeta de credito")
    case 18...22:
        tax = 2
        print("La tasa de interes es del 2%")
    case 23...25:
        tax = 1.5
        print("La tasa de interes es del 1.5%")
    default:
        print("La tasa de interes es del 1%")
}

let bankType = "B"

switch bankType {
case "B":
    print("Es el Banco B")
default:
    print("Es otro Banco")
}

var total: Float = 0
for transaction in transactions {
    total += (transaction * 100)
}

print(total)

print(accountTotal)

accountTotal -= total

print(accountTotal)

var total2: Float = 0.0
for key in transactionsDict.keys {
    for transaction in transactionsDict[key]! where transaction < 20 {
        total2 += transaction
    }
}

print(transactionsDict)
print(total2)

var nombre: String?

if let nombre = nombre {
    print(nombre)
}

nombre = "Andres"

print(nombre!)






