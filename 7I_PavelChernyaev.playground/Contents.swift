enum FileError: String, Error {
    case noExist = "Файла не существует"
    case noRead = "Нет прав на чтение"
    case noWrite = "Нет прав на запись"
    case noExecute = "Нет прав на запуск"
}

struct File {
    var name: String
    var access: String
    var content: String
    
    init(_ name: String, _ access: String, _ content: String) {
        self.name = name
        self.access = access
        self.content = content
    }
}

class FileManager {
    private let fileList = [
        File("readme.txt", "rwx", "Hello"),
        File("help.txt", "rw-", "Help content"),
        File("autorun.exe", "--x", "sfkjscsbvjffvjhebvhe"),
        File("photo.jpg", "r--", "qswqwcdscsjfdvdf")
        ]
    
    private func existFile(_ fileName: String) -> File? {
        return fileList.first(where: {$0.name == fileName})
    }
    
    private func checkRight(_ file: File, _ right: Character) -> Bool {
        return file.access.contains(right)
    }
    
    func readFile(fileName: String) throws -> String {
        guard let file = existFile(fileName) else { throw FileError.noExist }
        guard checkRight(file, "r") else { throw FileError.noRead}
        return file.content
    }
    
    func writeFile(fileName: String, content: String) throws -> String {
        guard var file = existFile(fileName) else { throw FileError.noExist }
        guard checkRight(file, "w") else { throw FileError.noRead}
        file.content += content
        return file.content
    }
    
    func runFile(fileName: String) -> (String?, FileError?) {
        guard let file = existFile(fileName) else { return (nil, .noExist) }
        guard checkRight(file, "x") else {return (nil, .noExecute) }
        return ("File in progress", nil)
    }
}

let fileManager = FileManager()

var files = ["sdfw", "readme.txt", "help.txt", "autorun.exe", "photo.jpg", "xxx.mp4"]

for fileName in files {
    print("--------------------")
    do {
        try print(fileManager.readFile(fileName: fileName))
        try print(fileManager.writeFile(fileName: fileName, content: " add new content"))
    } catch FileError.noExist {
        print("Файла \(fileName) не существует")
    } catch FileError.noRead {
        print("Файла \(fileName) закрыт для чтения")
    } catch FileError.noWrite {
        print("Файла \(fileName) закрыт для записи")
    } catch FileError.noExecute {
        print("Файла \(fileName) закрыт для исполнения")
    }
    
    let resultRun = fileManager.runFile(fileName: fileName)
    
    if let resOK = resultRun.0 {
        print(resOK)
    } else if let resErr = resultRun.1 {
        print("Ошибка запуска \(resErr.rawValue)")
    }
}

