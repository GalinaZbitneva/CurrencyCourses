//
//  Set Controller.swift
//  CurrencyCourses
//
//  Created by Галина Збитнева on 02.04.2021.
//

import UIKit

class Set_Controller: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func pushShowCourses(_ sender: AnyObject) {
        Model.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func pushCancelAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func  didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
