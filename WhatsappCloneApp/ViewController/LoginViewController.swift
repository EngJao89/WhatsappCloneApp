//
//  LoginViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 20/01/25.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    var auth: Auth!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auth = Auth.auth()
    }
    
    
    @IBAction func logar(_ sender: Any) {
        
        if let email = campoEmail.text {
            if let senha = campoSenha.text {
                
                auth.signIn(withEmail: email, password: senha) { (usuario, erro) in
                    
                    if erro == nil {
                        if let usuarioLogado = usuario {
                            print("Sucesso ao logar usuario! \(String(describing: usuarioLogado.user.email)) ")
                        }
                    }else{
                        print("Erro ao autenticar usuario!")
                    }
                    
                }
                
            }else{
                print("Digite seu senha")
            }
        }else{
            print("Digite seu email")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
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

