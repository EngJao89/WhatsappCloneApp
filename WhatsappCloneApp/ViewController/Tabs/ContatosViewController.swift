//
//  ContatosViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 21/01/25.
//

import UIKit

class ContatosViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableViewContatos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewContatos.separatorStyle = .none
    }
    
    /*Métodos para listagem na tabela */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaContatos", for: indexPath) as! ContatoTableViewCell
        
        let indice = indexPath.row
        
        celula.textoNome.text = "Jamilton Damasceno \(indice + 1)"
        celula.textoEmail.text = "jamilton@gmail.com  \(indice + 1)"
        celula.fotoContato.image = UIImage(named: "imagem-perfil")
        
        return celula
        
    }

}
