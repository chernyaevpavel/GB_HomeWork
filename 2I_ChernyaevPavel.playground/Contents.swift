//1 Функция которая определяет четное число или нет
func isEven(_ num: Int) -> Bool {
    return num % 2 == 0 ? true : false
}

//2 Функция которая определяет, делится ли число без остатка на 3
func isDevisionByThre(_ num: Int) -> Bool {
    return num % 3 == 0 ? true : false
}

//3 Создать возрастающий массив из 100 чисел
let n = 100
var arr = [Int](1...n)
//4 Удалить из массива все четные числа и все числа, которые не делятся на 3
//топорный метод, урок был по циклам и Вы наверняка хотите здесь увидеть реализацию цикла
//for i in (0..<arr.count).reversed() {
//    if isEven(num: arr[i]) || !isDevisionByThre(num: arr[i]) {
//        arr.remove(at: i)
//    }
//}
//почитал документацию apple, нашел красивый способ
arr.removeAll(where: { isEven($0) || !isDevisionByThre($0) })
print("Массив arr, из которого удалены все четные числа и числа, которые не делятся на 3 \n\(arr)")

//5 Функция, которая добавляет в массив новое число Фибоначчи
func addNumFibonachi(_ arr: inout [Int]) {
    switch arr.count {
    case 0, 1:
        arr.append(arr.count)
    default:
        arr.append(arr.last!+arr[arr.count - 2])
    }
}

arr = []
//добавляем в массив 50 чисел Фибоначчи
let countFibonachi = 50
for _ in 0...countFibonachi {
    addNumFibonachi(&arr)
}
print("Массив, в который добавили \(countFibonachi) чисел Фибоначчи \n \(arr)")


//6 Заполнить массив простыми числами до n методом Эратосфена
func primeNumbers(countNumbers n: Int) -> [Int] {
    //заполним массив
    var arr = [Int](2...n)
    var p = 2
    while p * p <= n {
        arr = arr.filter {$0 % p != 0 || $0 == p}
        p = arr.first(where: {$0 > p})!
    }
    return arr
}
let countPrimeNumbers = 100
print("Массив заполеный простыми числами до \(countPrimeNumbers)")
print(primeNumbers(countNumbers: countPrimeNumbers))

