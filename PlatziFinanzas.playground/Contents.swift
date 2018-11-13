import Foundation

var me = Person(name: "Andres", lastName: "Silva")

let account = Acccount(amount: 10_000, name: "X bank")

me.account = account

print(me.account!)

let entertainment = Budget(category: .entertainment, budget: 100, name: "Entretenimiento")
let health = Budget(category: .health, budget: 300, name: "Salud")

account.add(budget: entertainment)
account.add(budget: health)

do {
    try me.account?.addTransaction(
        transaction: .debit(
            value: 20,
            name: "Cafe con amigos",
            category: DebitCategories.food,
            date: Date(year: 2018, month: 11, day: 14)
        )
    )
} catch {
    print("Cafe con amigos", error)
}

do {
    try me.account?.addTransaction(
        transaction: .debit(
            value: 100,
            name: "Juego PS4",
            category: .entertainment,
            date: Date(year: 2018, month: 11, day: 10)
        )
    )
} catch {
    print("Error in game PS4", error)
}

do {
    try me.account?.addTransaction(
        transaction: .debit(
            value: 500,
            name: "PS4",
            category: .entertainment,
            date: Date(year: 2018, month: 11, day: 10)
        )
    )
} catch {
    print("Error in PS4", error)
}

try me.account?.addTransaction(
    transaction: .gain(
        value: 1000,
        name: "Salario",
        date: Date(year: 2018, month: 11, day: 1)
    )
)

var salary = try me.account?.addTransaction(
    transaction: .gain(
        value: 1000,
        name: "Salario",
        date: Date(year: 2018, month: 11, day: 1)
    )
)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    salary?.invalidateTrantraction()
    print("Invalidated")
}

print(me.account!.amount)

print(me.account?.amount ?? 0)

print(me.account?.lifeTimeValue())

