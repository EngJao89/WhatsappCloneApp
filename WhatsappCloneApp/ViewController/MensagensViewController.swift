//
//  MensagensViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 22/01/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MensagensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewMensagens: UITableView!
    @IBOutlet weak var fotoBotao: UIButton!
    
    @IBOutlet weak var mensagemCaixaTexto: UITextField!
    
    var listaMensagens: [String]!
    var idUsuarioLogado: String!
    var contato: Dictionary<String, Any>!
    
    var auth: Auth!
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth = Auth.auth()
        db = Firestore.firestore()
        
        //Recuperar id usuario logado
        if let id = auth.currentUser?.uid {
            self.idUsuarioLogado = id
        }
        
        //Configura título da tela
        if let nome = contato["nome"] {
            self.navigationItem.title = nome as? String
        }

        //configurações da tableView
        tableViewMensagens.separatorStyle = .none
        tableViewMensagens.backgroundView = UIImageView(image: UIImage(named: "bg"))
        
        //Configura lista de mensagens
        listaMensagens = ["Olá, tudo bem?", "Tudo ótimo meu amigo", "Estou muito doente e precisava falar com você, será que poderia ir na farmácia pegar alguns remédios?", "Posso sim, quais?", "Pode pegar um Resfenol, pode ser aquele dia e noite, sabe qual é?", "Sei sim!!", "Excelente!!Muuuuuuuito obrigadooo!!", "Por nada!! espero que melhore logo"]
        
    }
    
    
    @IBAction func enviarMensagem(_ sender: Any) {
        
        if let textoDigitado = mensagemCaixaTexto.text {
            if !textoDigitado.isEmpty {
                if let idUsuarioDestinatario = contato["id"] as? String {
                    
                    let mensagem = [
                        "idUsuario" : idUsuarioLogado,
                        "texto" : textoDigitado
                    ]
                
                    
                    salvarMensagem(idRemetente: idUsuarioLogado, idDestinatario: idUsuarioDestinatario, mensagem: mensagem)
                    
                }
            }
        }
        
    }
    
    func salvarMensagem(idRemetente: String, idDestinatario: String, mensagem: Dictionary<String, Any>) {
        
        db.collection("mensagens")
            .document( idRemetente )
            .collection( idDestinatario )
            .addDocument(data: mensagem)
        
        //limpar caixa de texto
        mensagemCaixaTexto.text = ""
        
    }
    
    /*Métodos para listagem na tabela */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaMensagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celulaDireita = tableView.dequeueReusableCell(withIdentifier: "celulaMensagensDireita", for: indexPath) as! MensagensTableViewCell
        
        let celulaEsquerda = tableView.dequeueReusableCell(withIdentifier: "celulaMensagensEsquerda", for: indexPath) as! MensagensTableViewCell
        
        let indice = indexPath.row
        let mensagem = self.listaMensagens[indice]
        
        if indice % 2 == 0 {
            celulaDireita.mensagemDireitaLabel.text = mensagem
            return celulaDireita
        }else{
            celulaEsquerda.mensagemEsquerdaLabel.text = mensagem
            return celulaEsquerda
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}
