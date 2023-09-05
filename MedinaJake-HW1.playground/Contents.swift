// Project: MedinaJake-HW1
// EID: jrm7784
// Course: CS371L

class Weapon {
    var type: String

    var damageLevels: [String: Int] = [
        "dagger":4,
        "axe":6,
        "staff":6,
        "sword":10,
        "none":1
    ]

    init(weaponType: String) {
        type = weaponType
    }
    
    func getType() -> String {
        return type
    }
}

class Armor {
    var type: String
    
    var acLevels: [String: Int] = [
        "plate": 2,
        "chain": 5,
        "leather": 8,
        "none": 10
    ]
    
    init(armorType: String) {
        type = armorType
    }
    
    func getType() -> String {
        return type
    }
}

class RPGCharacter {
    let name: String
    
    var armor = Armor(armorType: "none")
    var weapon = Weapon(weaponType: "none")
    
    let health: Int
    let spellPoints: Int
    
    init(name: String, health: Int, spellPoints: Int) {
        self.name = name
        self.health = health
        self.spellPoints = spellPoints
    }
    
}

class Fighter: RPGCharacter {
    var allowedWeapons: [String] = ["dagger", "axe", "staff", "sword", "none"]
    var allowedArmor: [String] = ["plate", "chain", "leather", "none"]

    init(name: String) {
        super.init(name: name, health: 40, spellPoints: 0)
    }

    func wield(weapon: Weapon) {
        if (allowedWeapons.contains(weapon.getType())) {
            self.weapon = weapon
            print("\(self.name) is now wielding a(n) \(weapon.getType())")
        } else {
            print("Weapon not allowed for this character class.")
        }
    }

    func unwield(weapon: Weapon) {
        self.weapon = Weapon(weaponType: "none")
        print("\(self.name) is no longer wielding anything.")
    }
    
    func putOnArmor(armor: Armor) {
        if (allowedArmor.contains(armor.getType())) {
            self.armor = armor
            print("\(self.name) is now wearing \(armor.getType())")
        } else {
            print("Armor not allowed for this character class.")
        }
    }
    
    func takeOffArmor(armor: Armor) {
        if (allowedArmor.contains(armor.getType())) {
            self.armor = Armor(armorType: "none")
            print("\(self.name) is now wearing \(armor.getType())")
        } else {
            print("Armor not allowed for this character class.")
        }
    }
}

class Wizard: RPGCharacter {
    var allowedWeapons: [String] = ["dagger", "staff"]
    var allowedArmor: [String] = ["none"]
    
    init(name: String) {
        super.init(name: name, health: 16, spellPoints: 20)
    }
}



// top level code

let plateMail = Armor(armorType: "plate")
let chainMail = Armor(armorType: "chain")
let sword = Weapon(weaponType: "sword")
let staff = Weapon(weaponType: "staff")
let axe = Weapon(weaponType: "axe")

let gandalf = Wizard(name: "Gandalf the Grey")
gandalf.wield(weaponObject: staff)

let aragorn = Fighter(name: "Aragorn")
aragorn.putOnArmor(armorObject: plateMail)
aragorn.wield(weaponObject: axe)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Fireball", target: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Lightning Bolt", target: aragorn)
aragorn.wield(weaponObject: sword)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Heal", target: gandalf)
aragorn.fight(opponent: gandalf)

gandalf.fight(opponent: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()
