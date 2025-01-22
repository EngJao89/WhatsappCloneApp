//
//  AjustesViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 20/01/25.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class AjustesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    var auth: Auth!
    var storage: Storage!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        auth = Auth.auth()
        storage = Storage.storage()
        
    }
    
    @IBAction func alterarImagem(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[ UIImagePickerController.InfoKey.originalImage ] as! UIImage
        
        self.imagem.image = imagemRecuperada
        
        let imagens = storage
            .reference()
            .child("imagens")
        
        
        if let imagemUpload = imagemRecuperada.jpegData(compressionQuality: 0.3) {
            
            if let usuarioLogado = auth.currentUser {
                
                let idUsuario = usuarioLogado.uid
                
                let nomeImagem = "\(idUsuario).jpg"
                imagens.child("perfil").child( nomeImagem )
                    .putData(imagemUpload, metadata: nil) { (metaData, erro) in
                        
                        if erro == nil {
                            print("Sucesso ao fazer upload da imagem")
                        }else {
                           print("Erro ao fazer upload da imagem")
                        }
                        
                }
                
            }
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
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
