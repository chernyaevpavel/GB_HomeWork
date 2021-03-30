//
//  Created by Павел Черняев on 28.03.2021.
//

enum Sex {
    case mhale, woman
}

class Human {
    var name: String
    let sex: Sex
    
    init(name: String, sex: Sex) {
        self.name = name
        self.sex = sex
    }
    
    func sayHello() {
        print("Hello")
    }
    
    deinit {
        print("Human out")
    }
    
}

class Father: Human {
    //сильные ссылки, потому что папа может
    var mother: Mother?
    var kids: Kids?
    var hasBeard: Bool = false {
        willSet {
            if !hasBeard && newValue {
                print("Папа отрастил бороду")
            } else if hasBeard && !newValue {
                print("Папа сбрил бороду")
            }
        }
    }
    
    override func sayHello() {
        print("Привет, я папа, и меня зовут \(name)")
    }
    
    func printFamily() {
        print("Папа \(name)")
        if let mom = mother {
            print("Мама \(mom.name)")
        }
        if let arrKids = kids?.kids {
            for kid in arrKids {
                print("Ребенок \(kid.name)")
            }
        }
    }
    
    init(name: String) {
        super.init(name: name, sex: .mhale)
    }
    
    deinit {
        print("Father out")
    }
}

class Mother: Human {
    //слабая ссылка
    weak var father: Father?
    //пробовал вариант ниже для теста, действительно начинаем течь по памяти, объекты не деинициализируются
    //var father: Father?
    init(name: String) {
        super.init(name: name, sex: .woman)
    }
    
    func sayHi() {
        print("Mom say Hi!")
    }
    
    deinit {
        print("Mother out")
    }
}

class Kid: Human {
    unowned var father: Father
    unowned var mother: Mother
//    это для теста
//    var father: Father
//    var mother: Mother
    
    init(name: String, sex: Sex, father: Father, mother: Mother) {
        self.father = father
        self.mother = mother
        super.init(name: name, sex: sex)
    }
    
    deinit {
        print("Kid out")
    }
}

class Kids {
    var kids: [Kid] = []
    
    func addKid(kid: Kid) {
        kids.append(kid)
    }
    
    init() {}
    
    init(kids: [Kid]) {
        self.kids = kids
    }
    
    deinit {
        print("Kids out")
    }
}

class Family {
    var father : Father
    var mother: Mother
    var kids: Kids?
    var countKids: Int {
        kids == nil ? 0 : kids!.kids.count
        }
    
    init(father: Father, mother: Mother) {
        self.father = father
        self.mother = mother
        self.father.mother = mother
    }
    
    init(father: Father, mother: Mother, kids: Kids){
        father.kids = kids
        father.mother = mother
        self.father = father
        self.mother = mother
        self.kids = kids
    }
    
    func printFamily() { //распечаткой семьи должен заниматься класс Family, но я хотел увидеть взаимодействие между объектами
        father.printFamily()
    }
    
    func addKid(kid: Kid) {
        kids?.addKid(kid: kid)
    }
}


if 1 == 1 { //это для проверки, что все объекты уничтожаются
    print("in 1")

    let father = Father(name: "Александр")
    father.name = "Саша"
    let mother = Mother(name: "Светлана")
    
    let kid1 = Kid(name: "Павлик", sex: .mhale, father: father, mother: mother)
    let kid2 = Kid(name: "Анечка", sex: .woman, father: father, mother: mother)
    
    let kids = Kids(kids: [kid1, kid2])
//    kids.addKid(kid: kid1)
//    kids.addKid(kid: kid2)
    let family = Family(father: father, mother: mother, kids: kids)
    family.printFamily()
    print(family.countKids)
    let kid3 = Kid(name: "Машенька", sex: .woman, father: father, mother: mother)
    family.addKid(kid: kid3)
    print(family.countKids)
    father.hasBeard = true
    father.hasBeard = false
    family.printFamily()
//  family.printFamily()
//  family.father.printFamily()
//  print(family.kids?.count)
//  print(family.father.kids?.count)
//  print(family.father.mother?.name)
//  print(father.mother?.name)
    kid1.mother.sayHi()
    father.sayHello()
}
print("out 1")
