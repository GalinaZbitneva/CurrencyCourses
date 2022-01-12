//
//  CoursesControllerTableViewController.swift
//  CurrencyCourses
//
//  Created by Галина Збитнева on 29.03.2021.
//

import UIKit

class CoursesControllerTableViewController: UITableViewController {
   
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // обновление внешнего вида таблицы в зависимости от того какой нотификэйшн был словлен
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "StartloadingXML"), object: nil, queue: nil) {(notification) in
            
              DispatchQueue.main.async {
              // здесь написан кон который отвечает за отображение колесика процесса обновления
                let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                activityIndicator.startAnimating()
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
            
        }
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) {(notification) in
            
              DispatchQueue.main.async {
              self.tableView.reloadData()
              self.navigationItem.title = Model.shared.currentDate
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
                
            }
            
        }
        
        // сообщение об ошибке при загрузке для приложения и алерт для пользователя
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ErrorWnenXMLLoading"), object: nil, queue: nil) { (notification) in
            let errorName = notification.userInfo?["Error name"]
            print(errorName)
            
            let alertError = UIAlertController(title: "Ошибка при загрузке файла", message: "Файл с курсами не загружен", preferredStyle: UIAlertController.Style.alert)
            let alertErrorOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertError.addAction(alertErrorOk)
            self.present(alertError, animated: true, completion: nil)
            
            DispatchQueue.main.async {
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
                
            }
            
        }


        navigationItem.title = Model.shared.currentDate
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Model.shared.loadXMLFile(date: nil)
        
    }
    
    @IBAction func pushRefreshAction(_ sender: AnyObject) {
           Model.shared.loadXMLFile(date: nil)
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // изменили число секций с 0 на 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Model.shared.curriencies.count // строк столько сколько видов валют
    }

    
    override func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CourseCell

        // создадим переменную которая будет хранить данные конкретной ячейки из таблицы (ячейка содержит имя валюты курс эквивалент и тд) класс карренси
        let courseForCell = Model.shared.curriencies[indexPath.row]
        
        cell.initCell(currencu: courseForCell)
        
        //можно убрать так как теперь у нас есть дизаун вида ячейки
        
        //cell.textLabel?.text = courseForCell.Name// столбец с названием валюты
      //  cell.detailTextLabel?.text = courseForCell.Value // столбец с курсом. нужно на сцене изменить стиль отображения ячеек

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
