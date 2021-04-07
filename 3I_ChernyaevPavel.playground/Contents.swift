enum EngineState: String {
    case start = "Двигатель запущен"
    case stop = "Двигатель заглушен"
}

enum WindowState: String {
    case open = "Окна открыты"
    case close = "Окна закрыты"
}

enum CarAction {
    case startEngine
    case stopEngine
    case openWindow
    case closeWindow
    case addCargo(Double)
    case unloadCargo(Double)
}

struct SportCar {
    let model: String
    let yearOfManufacture: UInt16
    let trunkVolume: Double
    var engineState: EngineState
    var windowState: WindowState
    var filledVolume: Double
    
    mutating func changeStateAuto(_ action: CarAction) {
        switch action {
        case .startEngine:
            self.engineState = .start
        case .stopEngine:
            self.engineState = .stop
        case .openWindow:
            self.windowState = .open
        case .closeWindow:
            self.windowState = .close
        case .addCargo(let count):
            if filledVolume + count > trunkVolume {
                print("Ошибка погрузки автомобиля. Сейчас в багажнике \(filledVolume) Максимально допустимый объем \(trunkVolume)")
                return;
            }
            self.filledVolume += count
        case .unloadCargo(let count):
            if filledVolume - count < 0 {
                print("Ошибка разгрузки автомобиля. Сейчас в багажнике \(filledVolume)")
                return;
            }
            self.filledVolume -= count
        }
    }
    
    func printInfoCar() {
        print("""
            ---------------------------------
            Легокоговой автомобиль
            Марка: \(model)
            Год выпуска: \(yearOfManufacture)
            Объем багажника: \(trunkVolume)
            \(engineState.rawValue)
            \(windowState.rawValue)
            В багажнике: \(filledVolume)
            ---------------------------------
            """)
    }
}

struct TrunkCar {
    let model: String
    let yearOfManufacture: UInt16
    let trailerVolume: Double
    var engineState: EngineState
    var windowState: WindowState
    var filledVolume: Double
}

var firstCar: SportCar
firstCar = SportCar(model: "Opel",
                    yearOfManufacture: 2010,
                    trunkVolume: 250,
                    engineState: .stop,
                    windowState: .close,
                    filledVolume: 0)

firstCar.printInfoCar()
firstCar.changeStateAuto(.startEngine)
firstCar.changeStateAuto(.openWindow)
firstCar.printInfoCar()
firstCar.changeStateAuto(.stopEngine)
firstCar.changeStateAuto(.closeWindow)
firstCar.changeStateAuto(.addCargo(15.6))
firstCar.printInfoCar()
firstCar.changeStateAuto(.addCargo(75.6))
firstCar.printInfoCar()
firstCar.changeStateAuto(.addCargo(200.6))
firstCar.printInfoCar()
firstCar.changeStateAuto(.unloadCargo(15))
firstCar.printInfoCar()
firstCar.changeStateAuto(.unloadCargo(100))
firstCar.printInfoCar()


enum Country: String {
    case Russia = "Россия"
    case Ukraine = "Украина"
    case Belarus = "Беларусь"
}

struct Client {
    var name: String
    var addres: String
    var phone: String
    var yearOfBrith: Int
    var country: Country
    
    init(name: String, addres: String = "", phone: String = "", yearOfBrith: Int, country: Country) {
        self.name = name
        self.addres = addres
        self.phone = phone
        self.yearOfBrith = yearOfBrith
        self.country = country
    }
    
    func printInfo(){
        print("""
            Клиент: \(name)
            Адрес: \(addres)
            Контактный телефон: \(phone)
            Год рождения: \(yearOfBrith)
            Страна: \(country.rawValue)
            """)
    }
}

var alex = Client(name: "Alex", addres: "г. Самара, Площадь Ленина, д. 2, кв.15", phone: "255-07-23", yearOfBrith: 2001, country: .Russia)
alex.printInfo()
