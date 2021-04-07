struct Queue<T>  {
    private var queue: [T] = []
    
    var count: Int {
        queue.count
    }
    
    var isEmpty: Bool {
        queue.isEmpty
    }
    
    mutating func clear() {
        queue.removeAll()
    }
        
    mutating func enqueue(element: T) {
        queue.append(element)
    }
    
    mutating func dequeue() -> T? {
        return count == 0 ? nil : queue.removeFirst()
    }
    
    func peek() -> T? {
        return count == 0 ? nil: queue.first
    }
    
    subscript(index: Int) -> T? {
        get {
            if index >= count { return nil }
            return queue[index]
        }
    }
    
    func filter(_ isIncluded: (T) -> Bool) -> [T] {
        return queue.filter(isIncluded) //можно и не изобретать велосипед
    }
    
    //но для тренировки можно и пописать, в целом принцип работы понятен
    func map(_ transform: (T) -> T) -> [T] {
        var newQueue = Array<T>()
        for item in queue {
            newQueue.append(transform(item))
        }
        return newQueue
    }
}



var x: Double
var mQDbl = Queue<Double>()
mQDbl.enqueue(element: 3)
print(mQDbl)

var mQ = Queue<Int>()
mQ.enqueue(element: 5)
mQ.enqueue(element: 8)
mQ.enqueue(element: 100)
print("Добавил \(mQ.count) элемента Int \(mQ)")
print("Фильтр \(mQ.filter({$0 > 6}))")
print("Map \(mQ.map({$0 * 10}))")
print("Сабскрипт \(mQ[0]) \(mQ[3]) \(mQ[2])")
print("Первый в очередеи \(mQ.peek()!)")
mQ.dequeue()
print("Первый в очередеи \(mQ.peek()!)")
print(mQ)


var mQStr = Queue<String>()
mQStr.enqueue(element: "Abc")
mQStr.enqueue(element: "Str")
mQStr.enqueue(element: "Label")
print("Фильтр \(mQStr.filter({$0.count > 3 }))")


struct Rectangle {
    var lenght: Double
    var width: Double
    var square: Double {
        lenght * width
    }
}

var mQRect = Queue<Rectangle>()
mQRect.enqueue(element: Rectangle(lenght: 15, width: 6))
mQRect.enqueue(element: Rectangle(lenght: 10, width: 5))
print(mQRect.filter({$0.square > 50}))

//структура на дженериках, ограниченная 3-мя типам, ответ на собственный вопрос. просто проверил как это работает, так вообще принято делать?
protocol MyProtocol {}
extension Int: MyProtocol {}
extension Double: MyProtocol {}
extension String: MyProtocol {}

struct MyStruct<T: MyProtocol> {
    var x: T
    var y: T
}

var mS = MyStruct<Int>(x: 5, y: 6)
mS.x = 5
mS.y = 5
print(mS)

var mS1 = MyStruct<String>(x: "a", y: "b")

//var mS2 = MyStruct<Float>(x: 5, y: 6) ошибка компиляции

