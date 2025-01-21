//
//  AjustesViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 20/01/25.
//

import UIKit
import FirebaseAuth

class AjustesViewController: UIViewController {
    
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth = Auth.auth()
        
    }
    
    @IBAction func deslogar(_ sender: Any) {
        
        do {
            try auth.signOut()
        } catch  {
            print("Erro ao deslogar usuário!")
        }
        
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
