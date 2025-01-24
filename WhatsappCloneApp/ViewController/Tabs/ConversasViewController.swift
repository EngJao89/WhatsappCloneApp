//
//  ConversasViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 23/01/25.
//

import UIKit
import FirebaseUI
import FirebaseAuth
import FirebaseFirestore

class ConversasViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableViewConversas: UITableView!
    
    
    var auth: Auth!
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConversas.separatorStyle = .none
        
        auth = Auth.auth()
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaConversa", for: indexPath) as! ConversaTableViewCell
        
        celula.nomeConversa.text = "Jamilton Damasceno"
        celula.ultimaConversa.text = "Me responde!!"
        celula.fotoConversa.image = UIImage(named: "imagem-perfil")
        
        return celula
        
    }
    

}
