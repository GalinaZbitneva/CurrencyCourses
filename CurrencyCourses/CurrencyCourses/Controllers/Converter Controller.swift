//
//  Converter Controller.swift
//  CurrencyCourses
//
//  Created by Галина Збитнева on 03.04.2021.
//

import UIKit

class Converter_Controller: UIViewController {

    @IBOutlet weak var burttonFrom: UIButton!
    
    
    @IBOutlet weak var buttonTo: UIButton!
    
    
    @IBOutlet weak var textFrom: UITextField!
    
    
    @IBOutlet weak var textTo: UITextField!
    
    @IBAction func pushFromAction(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(identifier: "selectedCurrencyNSID" ) as! UINavigationController //принудительно приводим к UINavigationController
        (nc.viewControllers[0] as! SelectedCurrencyController).flagCurrency = .from
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func pushToAction(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(identifier: "selectedCurrencyNSID" ) as! UINavigationController //принудительно приводим к UINavigationController
        (nc.viewControllers[0] as! SelectedCurrencyController).flagCurrency = .to
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var labelCoursesForDate: UILabel!
    
    
    
    @IBAction func textFromEditingChange(_ sender: Any) {
        
        //количество мы берем из поля ткст Фром
        // если оно пустое или символы неккоректны то будет нил
        // если не нил, то призводим конвертацию функцией конверт и данные записываются в поле текстТу
        
        // с нил сравнение убрали тк в функции конверт уже есть проверка на пусто и др символы
        let amount  = Double(textFrom.text!)
        
            textTo.text = Model.shared.convert(amount: amount)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFrom.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
// пишем функцию которая будет одновлять внешний вид вьюхи в процессе загрузки и функцию которая будет бновлять название валют на кнопках
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        textFromEditingChange(self) // после того как изменим валюты изменятся суммы в окнах б поэтому вызываем этот метод чтобы обновить окно
        labelCoursesForDate.text = "Курс за дату: \(Model.shared.currentDate)" //здесь меняем дату на выбранную
        navigationItem.rightBarButtonItem = nil // здесь кнопка Готово становится неактивной

    }
   
    
    func refreshButtons(){
        buttonTo.setTitle(Model.shared.toCurrency.CharCode, for: UIControl.State.normal)
        //внешний вид кнопки берем из модели
        
        burttonFrom.setTitle(Model.shared.fromCurrency.CharCode, for: UIControl.State.normal)
    }
    
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    
    
    @IBAction func pushButtonDone(_ sender: Any) {
        textFrom.resignFirstResponder() // убрали клавиатуру
        navigationItem.rightBarButtonItem = nil // убрали кнопку "готово"
    }
    
}

extension Converter_Controller: UITextFieldDelegate {
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone
        return true
    }
}
