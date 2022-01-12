//
//  SelrctCurrencyController.swift
//  CurrencyCourses
//
//  Created by Галина Збитнева on 04.04.2021.
//

import UIKit

enum FlugCurrencySelected {
    case from
    case to
}


class SelectedCurrencyController: UITableViewController {

    @IBAction func pushActionCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var flagCurrency: FlugCurrencySelected = .from // будет определять какая валюта выбрана для конвертации
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.curriencies.count // number of rows
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectCell
        
        let currentCurrency: Currency = Model.shared.curriencies[indexPath.row] // заполнение строк таблицы бывора валюты в selectCurrencyController
        
        cell.initCellSelected(currency: currentCurrency)
        
        //cell.textLabel?.text = currentCurrency.Name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency: Currency  = Model.shared.curriencies[indexPath.row]
        if flagCurrency == .from {
            Model.shared.fromCurrency = selectedCurrency
        }
        if flagCurrency == .to {
            Model.shared.toCurrency = selectedCurrency
        }
        dismiss(animated: true, completion: nil)
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
