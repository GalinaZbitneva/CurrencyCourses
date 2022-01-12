//
//  Model.swift
//  CurrencyCourses
//
//  Created by Галина Збитнева on 28.03.2021.
//

import UIKit

class Currency {
    var NumCode: String?
    var CharCode: String?
    var Nominal: String?
    var nominalDouble: Double?
    var Name: String?
    var Value: String?
    var valueDouble: Double?
    
    var imageFlag: UIImage? {
        if let CharFlag = CharCode {
            return UIImage(named: CharFlag + ".png")
        }
        return nil
    }
   
    
    class func rouble() -> Currency {
        let r = Currency()
        r.CharCode = "RUR"
        r.Name = "Российский рубль"
        r.Nominal = "1"
        r.nominalDouble = 1
        r.Value = "1"
        r.valueDouble = 1
        
        return r
    }

}


class Model: NSObject, XMLParserDelegate {

    static let shared = Model()
    var curriencies: [Currency] = [] // по сути это таблица с курсами валют и котировками на сцене
    // указываем путь к файлу с котировками
    var currentDate: String = ""// переменная содержащая теккущую дату
    
    //переменные для конвертации валют
    
    var fromCurrency: Currency = Currency.rouble()
    var toCurrency: Currency = Currency.rouble()
    
    func convert(amount: Double?) -> String{
        // амонт будет нил если значение пустое или не число
        
        if amount == nil{
            return ""
        }
        let d = ((fromCurrency.nominalDouble! * fromCurrency.valueDouble!) / (toCurrency.nominalDouble! * toCurrency.valueDouble!)) * amount!
        return String(d)
    }
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask,
                                            true)[0] + "/Data.xml"
        // если файл существует в нашем случае файл с курсами валют, то :
        if FileManager.default.fileExists(atPath: path){
            return path
        }
       return Bundle.main.path(forResource: "Data", ofType: "xml")!
      
    }
    // указывает юрл адрес файла
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
    
    //функция для загрузки файла XML c cb.ru и его сохранение в каталоге приложения
    //http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002
    
    func loadXMLFile(date: Date?){
        var strURL = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" // важно именно в таком виде писать "dd/MM/yyyy" иначе не будут обновляться данные
            strURL = strURL + dateFormatter.string(from: date!)
           
        }
        let url = URL(string: strURL)
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            var errorGlobal: String?
            if error == nil{
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask,
                                                               true)[0] + "/Data.xml"
                let urlForSave = URL(fileURLWithPath: path)
                do{
                    try data?.write(to: urlForSave)
                    print(path) // название файла выведется в консоли и можно будет проверидь в folder что файл действительно обновился
                    print ("Файл загружен") //загрузили файл далее нужно его распарсить
                    self.parseXML()
                    
            }
                catch{
                    print("Error shen save data: \(error.localizedDescription)")
                    errorGlobal = error.localizedDescription
                }
        }
            else {
                print ("Error when loadXMLFile: \(error.debugDescription)")
                errorGlobal = error?.localizedDescription
            }
            
            if let errorGlobal = errorGlobal {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ErrorWnenXMLLoading"), object: self, userInfo: ["Error name" : errorGlobal])
            }
        }
        // уведомление по всему приложению о том что идет процесс загрузки файла
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "StartloadingXML"), object: self)
        task.resume()
        
    }
    
    // распарсить XML и положить его в curriencies: [Currency], отправить уведомление приложению
    func parseXML(){
        curriencies = [Currency.rouble()] // обнуляем массив после предыдущего запуска функции
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        
        print("Данные обновлены")
        // уведомление по всему приложению о том что загружен файл
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
        
        for c in curriencies {
            if c.CharCode == fromCurrency.CharCode {
                fromCurrency = c
            }
            if c.CharCode == toCurrency.CharCode{
                toCurrency = c
            }
        }
    }
    
    //создали переменную соответсивующую классу Currency
    var currentCurrency: Currency?
    
   //эта функция ищет открывающий тег
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        if elementName == "ValCurs" {
            if let currentDateString = attributeDict["Date"]{
                currentDate = currentDateString
            }
        }
        
        if elementName == "Valute" { // Valute это  имя тега из файла Data
            currentCurrency = Currency()
        }
    }
    
    
    // ищет символы между открывающим и закрвающим тегом
        // объявляем переменную которая является строкой символов между тегами
        var currentCharacters: String = ""
        func parser(_ parser: XMLParser, foundCharacters string: String){
            currentCharacters = string
        }


    // ищет закрывающий тег
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if elementName == "Valute" {
            curriencies.append(currentCurrency!) //добавляем в массив валют валюту currentCurrency
        }
            if elementName == "NumCode" {
                currentCurrency?.NumCode = currentCharacters
            }
            if elementName == "CharCode" {
                currentCurrency?.CharCode = currentCharacters
            }
            if elementName == "Nominal" {
                currentCurrency?.Nominal = currentCharacters
                currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
            }
            if elementName == "Name" {
                currentCurrency?.Name = currentCharacters
            }
            if elementName == "Value" {
                currentCurrency?.Value = currentCharacters
                currentCurrency?.valueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
            }
        
    }
    

    
}
