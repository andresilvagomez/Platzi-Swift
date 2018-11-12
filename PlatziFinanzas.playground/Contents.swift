import Foundation

struct Acccount {
    var amounth: Float = 0
    var name: String = ""
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


