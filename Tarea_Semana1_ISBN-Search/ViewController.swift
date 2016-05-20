//
//  ViewController.swift
//  Tarea_Semana1_ISBN-Search
//
//  Created by Diseño01 on 18/05/16.
//  Copyright © 2016 DanTuknal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var botLimpiar: UIButton!
    @IBOutlet weak var isbnResultadoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        isbnTextField.delegate=self
        
        //Aunque se indique que le clear button este visible siempre no aparecerá si el campo de texto esta vacío ya que no hay nada que borrar.
        isbnTextField.clearButtonMode = UITextFieldViewMode.Always
        isbnTextField.text = "Ingresa el ISBN que deseas buscar"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDoneEditing(sender:UITextField){
        //Desaparece el teclado al presionar INTRO/SEARCH/etc
        sender.resignFirstResponder()
        sincrono ()
    }
    
    @IBAction func backgroundTap(sender:UIControl){
        //Desaparece el teclado cuando toco fuera del campo
        isbnTextField.resignFirstResponder()
    }

    @IBAction func buscarISBN(sender: AnyObject) {
        sincrono ()
    }
    
    @IBAction func limpiarCampos(sender: AnyObject) {
        isbnTextField.text = ""
        isbnResultadoTextView.text = ""
    }
    
    func sincrono (){
        //el isbn a capturar
        var isbnBuscar = isbnTextField.text!
        if isbnBuscar == "Ingresa el ISBN que deseas buscar" {
            isbnBuscar = ""
        }
        //creo la url
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urls+isbnBuscar)
        let datos : NSData? =  NSData (contentsOfURL: url!)
        
        //valido conexion a internet y si la peticion vuelve vacía porque no encontró el isbn que buscamos -> {}
        if datos == nil{
            
            errorAlert("Error en la conexion", mensaje: "Hay un problema con tu conexión a internet. Por favor, checala e intenta de nuevo.")
            
        }else {
            
            let texto = NSString(data:datos!, encoding:NSUTF8StringEncoding)
            //print(texto)
            
            if texto != "{}"{
                
                    self.isbnResultadoTextView.text = texto! as String
                
                }else{
                
                    self.errorAlert("Error en el ISBN", mensaje: "No se encontró un libro asociado al ISBN:\(isbnBuscar) que ingresaste. Por favor, intenta de nuevo con otro ISBN.\n\nMuchas gracias!")
                
                }
            
        }
   
    }
    
    func errorAlert (error: String, mensaje: String) {
        let alert: UIAlertController = UIAlertController(title: error, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
        isbnResultadoTextView.text = mensaje
    }
    

}

