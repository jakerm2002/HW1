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
    
    func getDamage() -> Int {
        return damageLevels[type]!
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
    
    func getACLevel() -> Int {
        return acLevels[type]!
    }
}

class RPGCharacter {
    let name: String
    
    var armor = Armor(armorType: "none")
    var weapon = Weapon(weaponType: "none")
    
    var health: Int
    var spellPoints: Int
    
    let maxHealth: Int
    let maxSpellPoints: Int
    
    init(name: String, health: Int, spellPoints: Int) {
        self.name = name
        self.health = health
        self.spellPoints = spellPoints
        self.maxHealth = health
        self.maxSpellPoints = spellPoints
    }
    
    func wield(weaponObject weapon: Weapon) {
        self.weapon = weapon
        print("\(self.name) is now wielding a(n) \(weapon.getType())")
    }
    
    func unwield() {
        self.weapon = Weapon(weaponType: "none")
        print("\(self.name) is no longer wielding anything.")
    }
    
    func putOnArmor(armorObject armor: Armor) {
        self.armor = armor
        print("\(self.name) is now wearing \(armor.getType())")
    }
    
    func takeOffArmor() {
        self.armor = Armor(armorType: "none")
        print("\(self.name) is no longer wearing any armor.")
    }
    
    func show() {
        print(name)
        print("   Current Health: \(health)")
        print("   Current Spell Points: \(spellPoints)")
        print("   Wielding: \(weapon.getType())")
        print("   Wearing: \(armor.getType())")
        print("   Armor class: \(armor.getACLevel())")
    }
    
    func fight(opponent: RPGCharacter) {
        print("\(name) attacks \(opponent.name) with a(n) \(weapon.getType())")
        opponent.health = opponent.health - weapon.getDamage()
        print("\(name) does \(weapon.getDamage()) damage to \(opponent.name)")
        print("\(opponent.name) is now down to \(opponent.health) health")
        checkForDefeat(character: opponent)
    }
    
    func checkForDefeat(character: RPGCharacter) {
        if character.health <= 0 {
            print("\(character.name) has been defeated!")
        }
    }
}

class Fighter: RPGCharacter {
    var allowedWeapons: [String] = ["dagger", "axe", "staff", "sword", "none"]
    var allowedArmor: [String] = ["plate", "chain", "leather", "none"]

    init(name: String) {
        super.init(name: name, health: 40, spellPoints: 0)
    }

    override func wield(weaponObject weapon: Weapon) {
        if (allowedWeapons.contains(weapon.getType())) {
            super.wield(weaponObject: weapon)
        } else {
            print("Weapon not allowed for this character class.")
        }
    }
    
    override func putOnArmor(armorObject armor: Armor) {
        if (allowedArmor.contains(armor.getType())) {
            super.putOnArmor(armorObject: armor)
        } else {
            print("Armor not allowed for this character class.")
        }
    }
}

class Wizard: RPGCharacter {
    var allowedWeapons: [String] = ["dagger", "staff"]
    var allowedArmor: [String] = ["none"]
    
    static var spells: [String: (cost: Int, effect: Int)] = [
        "Fireball" : (3, 5),
        "Lightning Bolt" : (10, 10),
        "Heal" : (6, -6)
    ]
    
    init(name: String) {
        super.init(name: name, health: 16, spellPoints: 20)
    }
    
    override func wield(weaponObject weapon: Weapon) {
        if (allowedWeapons.contains(weapon.getType())) {
            super.wield(weaponObject: weapon)
        } else {
            print("Weapon not allowed for this character class.")
        }
    }
    
    override func putOnArmor(armorObject armor: Armor) {
        if (allowedArmor.contains(armor.getType())) {
            super.putOnArmor(armorObject: armor)
        } else {
            print("Armor not allowed for this character class.")
        }
    }
    
    func castSpell(spellName: String, target: RPGCharacter) {
        print("\(name) casts \(spellName) at \(target.name)")
        if Wizard.spells[spellName] == nil {
            print("Unknown spell name. Spell failed.")
            return
        }
        if spellPoints < Wizard.spells[spellName]!.cost {
            print("Insufficient spell points")
            return
        }
        
        let prevHealth = target.health
        target.health = target.health - Wizard.spells[spellName]!.effect
        if target.health > target.maxHealth {
            target.health = target.maxHealth
        }
        
        spellPoints = spellPoints - Wizard.spells[spellName]!.cost
        if spellPoints > maxSpellPoints {
            spellPoints = maxSpellPoints
        }
        
        if spellName == "Heal" {
            print("\(name) heals \(target.name) for \(target.health - prevHealth) health points")
            print("\(target.name) is now at \(target.health) health")
        } else {
            print("\(name) does \(prevHealth - target.health) damage to \(target.name)")
            print("\(target.name) is now down to \(target.health) health")
            checkForDefeat(character: target)
        }
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
