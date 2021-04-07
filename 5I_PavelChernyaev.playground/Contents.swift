//Некий функционал для списка покупок
//Пользователь накидывает в список товары из разных категорий
//Помимо того, что мы харним спискок, мы так же можем показать ориентировочную стоимость покупок и их вес
import Foundation

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

enum EdIzm: String {
    case sht = "шт"
    case kg = "кг"
    case ten = "десяток"
}

enum ProductCategory: String {
    case food = "Еда"
    case houseChemikal = "Бытовая химия"
    case clothes = "Одежда"
    case userCategory = "Другое"
}

protocol ShoppingListProtocol {
    var name: String { get set }
    var price: Double { get set }
    var weight: Double { get set }
    var edIzm: EdIzm { get }
}

extension ShoppingListProtocol {
    mutating func changePrice(price: Double) {
        self.price = price
    }
    mutating func changeWeight(weight: Double) {
        self.weight = weight
    }
}

enum FoodType: String {
    case meat = "Мясо"
    case fish = "Рыба"
    case vegetables = "Овощи"
    case readyDish = "Готовые блюда"
    case drink = "Напитки"
    case other = "Другое"
}

class Product: ShoppingListProtocol {
    var name: String
    var price: Double
    var weight: Double
    var edIzm: EdIzm
    
    init(name: String, price: Double, weight: Double, edIzm: EdIzm) {
        self.name = name
        self.price = price
        self.weight = weight
        self.edIzm = edIzm
    }
}

class Food: Product {
    let type: FoodType
    let category = ProductCategory.food
    
    init(name: String, price: Double, weight: Double, edIzm: EdIzm, type: FoodType) {
        self.type = type
        super.init(name: name, price: price, weight: weight, edIzm: edIzm)
    }
}

enum HomeAnimal {
    case cat
    case dog
}

class FoodAnimals: Food {
    let animalType: HomeAnimal
    init(animalType: HomeAnimal, name: String, type: FoodType, price: Double, weight: Double, edIzm: EdIzm) {
        self.animalType = animalType
        super.init(name: name, price: price, weight: weight, edIzm: edIzm, type: type)
    }
}

class HouseChemikal: Product {
    let category = ProductCategory.houseChemikal
    
    override init(name: String, price: Double, weight: Double, edIzm: EdIzm) {
        super.init(name: name, price: price, weight: weight, edIzm: edIzm)
    }
}

class Clothes: Product {
    var size: Double
    init(name: String, price: Double, weight: Double, edIzm: EdIzm, size: Double) {
        self.size = size
        super.init(name: name, price: price, weight: weight, edIzm: edIzm)
    }
}

class ShoppingItem {
    var prduct: ShoppingListProtocol //товар
    var barcode: String? //штрих-код товара
    var count = 1 //количество, которое хотим купить
    
    init(product: ShoppingListProtocol) {
        self.prduct = product
    }
}

enum ActionCount {
    case add
    case reduce
}

class ShoppingList {
    private var list: [ShoppingItem] = [] //что бы нельзы было менять напрямую извне

    func addProduct(item: ShoppingListProtocol) -> ShoppingItem? {
        //здесь можно логгировать изменения, хотя не знаю, правильно ли это
        if let _ = findByNmame(name: item.name) { //такой элемент уже есть в списке
            return nil
        }
        let newProduct = ShoppingItem(product: item)
        list.append(newProduct)
        return newProduct
    }
    
    func addProduct(arr: [ShoppingListProtocol]) {
        for item in arr {
            addProduct(item: item)
        }
    }
    
    func changeCount(val: Int, item: ShoppingItem, action: ActionCount) -> Bool {
        if let index = list.firstIndex(where: { $0 === item }) {
            switch action {
            case .add:
                list[index].count += val
            case .reduce:
                list[index].count -= val
                if list[index].count <= 0 {
                    list.remove(at: index)
                }
            }
            return true
        }
        return false
    }
    
    func clearList() {
        list = []
    }
    
    func delProduct(name: String) -> ShoppingItem? {
        if let index = findIndexByName(name: name) {
            return list.remove(at: index)
        } else {
            return nil
        }
    }
    
    func printShoppingList() {
        print("Список покупок")
        for i in list {
            print("\(i.prduct.name) - \(i.count) \(i.prduct.edIzm.rawValue) Цена: \(i.prduct.price)")
        }
        print("Плановая сумма покупок: \(totalSum)")
        print("Вес покупок \(totalWeight) кг")

    }
    
    private func findIndexByName(name: String) -> Int? {
        if let index = list.firstIndex(where: {$0.prduct.name.lowercased() == name.lowercased()}) {
            return index
        }
        return nil
    }
    
    
}

extension ShoppingList { //это просто для тренировки расширений
    var totalSum: Double {
        list.reduce(0, { $0 + $1.prduct.price * Double($1.count) }).rounded(digits: 2)
    }
    
    var totalWeight: Double {
        list.reduce(0, {$0 + $1.prduct.weight * Double($1.count) }).rounded(digits: 3)
    }
    
    func findByNmame(name: String) -> ShoppingItem? {
        if let inddex = findIndexByName(name: name) {
            return list[inddex]
        }
        return nil
    }
}

let cutlet = Food(name: "Котлета", price: 109, weight: 0.2, edIzm: .sht, type: .readyDish)
let eggs = Food(name: "Яйца", price: 69, weight: 0.3, edIzm: .ten, type: .other)
let bread = Food(name: "Хлеб", price: 34, weight: 0.4, edIzm: .sht, type: .other)
let potatoes = Food(name: "Каратофель", price: 40, weight: 1, edIzm: .kg, type: .vegetables)
let cheese = Food(name: "Сыр", price: 200, weight: 0.3, edIzm: .sht, type: .other)
let catFood = FoodAnimals(animalType: .cat, name: "Кошачий корм", type: .other, price: 27, weight: 0.1, edIzm: .sht)
let toiletPapir = HouseChemikal(name: "Туалетная бумага", price: 70, weight: 0.3, edIzm: .sht)
var toothPaste = HouseChemikal(name: "Зубная паста", price: 130, weight: 0.2, edIzm: .sht)
toothPaste.changePrice(price: 150)
let shoppingList = ShoppingList()

//shoppingList.addProduct(item: cutlet)
//shoppingList.addProduct(item: eggs)
//shoppingList.addProduct(item: bread)
//shoppingList.addProduct(item: potatoes)
//shoppingList.addProduct(item: cheese)
//shoppingList.addProduct(item: catFood)
//shoppingList.addProduct(item: toiletPapir)

//маленький перфекционист в моей голове апплодирует стоя)
shoppingList.addProduct(arr: [cutlet, eggs,bread, potatoes, cheese, catFood, toiletPapir])

var item: ShoppingItem
let paste = shoppingList.addProduct(item: toothPaste)
if let item = paste {
    shoppingList.changeCount(val: 2, item: item, action: .add)
}

let toothPaste2 = HouseChemikal(name: "Зубная паста", price: 130, weight: 0.2, edIzm: .sht)
if let paste2 = shoppingList.addProduct(item: toothPaste2) {
    print("Add paste 2 \(paste2)")
} else {
    print("Err add paste 2")
}

shoppingList.printShoppingList()
shoppingList.findByNmame(name: "Колбаса")
shoppingList.findByNmame(name: "Хлеб")

//shoppingList.delProduct(name: "Зубная паста")
shoppingList.changeCount(val: 10, item: paste!, action: .reduce)
shoppingList.printShoppingList()


