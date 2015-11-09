//
//  ViewControllerExit.swift
//  Cuestionarios
//
//  Created by Cornellana on 9/11/15.
//  Copyright © 2015 Cornellana. All rights reserved.
//

import UIKit

class ViewControllerExit: UIViewController {

    @IBOutlet weak var messageFinal: UILabel!
    @IBOutlet weak var imagenFinal: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resultadosASacar = Int(preguntasExamen[0][2])!
        
        if respuestasBuenas < resultadosASacar {
            
            messageFinal.text = "Sorry, you dindn't pass the questionnaire, the minimum of correct answers is \(resultadosASacar)"
            messageFinal.textColor = rojo
            imagenFinal.image = UIImage(named: "Failure")
        } else {
            messageFinal.text = "Congratulations, you passed the questionnaire, the minimum of correct answers is \(resultadosASacar)"
            messageFinal.textColor = verde
            imagenFinal.image = UIImage(named: "Party")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func botonTerminar(sender: UIBarButtonItem) {
    
        exit(0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
