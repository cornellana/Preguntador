//
//  ViewController.swift
//  Cuestionarios
//
//  Created by Cornellana on 1/11/15.
//  Copyright © 2015 Cornellana. All rights reserved.
//

import UIKit

// Definicion de la encuesta

    var preguntasExamen = [[String]]()
    var alternativasPregunta = [[String]]()
    var misRespuestas = Array<Array<String>>()
    var respuestaPregunta = ""
    let indicePreguntas = ["a","b","c","d"]
    let maxPreguntas = indicePreguntas.count
    var maxPaginas = 0


//================================================================

    var respuestasBuenas = 0
    var numPagina:Int = 1


    let rojo = UIColor.redColor()
    let verde = UIColor.greenColor()

    let correcto = UIImage(named: "correctAnswer")
    let incorrecto = UIImage(named: "incorrectAnswer")

    var botones:[String:UIButton] = [:]
    var respuestas:[String:UILabel] = [:]

class ViewController: UIViewController {

    @IBOutlet weak var textoPregunta: UILabel!
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!

    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var bacKButton: UIBarButtonItem!
    
    @IBOutlet weak var restartButton: UIBarButtonItem!
    
    @IBOutlet weak var respuestaAPregunta: UILabel!
    @IBOutlet weak var respuestaBPregunta: UILabel!
    @IBOutlet weak var respuestaCPregunta: UILabel!
    @IBOutlet weak var respuestaDPregunta: UILabel!
    
    @IBOutlet weak var numeroPregunta: UILabel!
    @IBOutlet weak var numeroPuntos: UILabel!

    
    
    @IBOutlet weak var fotoImagen: UIImageView!
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numeroPregunta.text = "\(numPagina)"
        numeroPuntos.text = "\(respuestasBuenas)"
        
        
        nextButton.enabled = false
        preguntasExamen = [["Trivia Animales","4","3","Animales"],
            ["A Playpus is:","c","platypus"],
            ["Do polar bears eat penguins?","b","polarBear"],
            ["What do giant pandas eat exclusively?","b","panda"],
            ["What kind of animal is the lion","a","leon"]]
        alternativasPregunta = [["a","b"],
            ["An Australian hedgehog","There is no such beast","A fuury mammal wich lays eggs, has a duck's bill and is poisonous"],
            ["No, it's bad for their figure","No they live in opposite poles of the planet","Yes it's their favorite snack","they need eat two every day"],
            ["McDonalds's","Bamboo"],
            ["Carnivoro","Hervivoro","omnivoro"]]
         maxPaginas = alternativasPregunta.count - 1
        

        
        // Pinta Pantalla Inicial
        
         botones = ["a":aButton, "b":bButton, "c":cButton, "d":dButton]
         respuestas = ["a":respuestaAPregunta, "b":respuestaBPregunta, "c":respuestaCPregunta, "d":respuestaDPregunta]
       
    paginaInicial()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func aButtonPressed(sender: UIButton) {
        comprobarRespuesta("a")
    }
    
    @IBAction func bButtonPressed(sender: UIButton) {
        comprobarRespuesta("b")
    }
    
    @IBAction func cButtonPressed(sender: UIButton) {
        comprobarRespuesta("c")
    }
    
    @IBAction func dButtonPressed(sender: UIButton) {
        comprobarRespuesta("d")
    }
    @IBAction func darLaRespuesta(sender: UIBarButtonItem) {
        respuestasBuenas--
        comprobarRespuesta(respuestaPregunta)
    }
  
    @IBAction func restartButtonPressed(sender: UIBarButtonItem) {
        
        paginaInicial()
    }

     @IBAction func nextButtonPressed(sender: UIBarButtonItem){

        
        textoPregunta.text = preguntasExamen[numPagina][0]
        reactivateButtons()
        
        for var i:Int = 0; i < maxPreguntas; i++ {
        pintaPregunta(numPagina, ind: i)
        }
        
        numeroPregunta.text = "\(numPagina)"
        respuestaPregunta = preguntasExamen[numPagina][1]
        fotoImagen.image = UIImage(named: preguntasExamen[numPagina][2])
        
        nextButton.enabled = true
        bacKButton.enabled = true
        
        if numPagina == 1 {
            bacKButton.enabled = false
        } else {
            if numPagina == maxPaginas {
                nextButton.enabled = false
            }
        }
        numPagina++
    }

    @IBAction func backButtonPressed(sender: UIBarButtonItem) {

        numPagina = numPagina-2
        
        textoPregunta.text = preguntasExamen[numPagina][0]
        reactivateButtons()
        
        for var i:Int = 0; i < maxPreguntas; i++ {
            pintaPregunta(numPagina, ind: i)
        }
        
        numeroPregunta.text = "\(numPagina)"
        respuestaPregunta = preguntasExamen[numPagina][1]
        fotoImagen.image = UIImage(named: preguntasExamen[numPagina][2])
        
        if numPagina == Int(preguntasExamen[0][1]) {
            numPagina = 0
        }
        
        nextButton.enabled = true
        bacKButton.enabled = true
        
        if numPagina == 1 {
            bacKButton.enabled = false
        } else {
            if numPagina == 0 {
                nextButton.enabled = false
            }
        }
        numPagina++
        
      }
    
    
    
    
    // Funciones
    
    
    
    func resultadoCorrecto (laCorrectaEs:String) {

        for var i: String in indicePreguntas {
        botones[i]!.enabled = false
        if laCorrectaEs == i {
            botones[i]!.enabled = true
            respuestasBuenas++
            numeroPuntos.text = "\(respuestasBuenas)"
        }
      }
    }
    func resultadoIncorrecto (laCorrectaEs:String) {
        
        for var i: String in indicePreguntas {
            botones[i]!.enabled = false
            if laCorrectaEs == i {
                botones[i]!.enabled = true
            }
        }
    }

    func reactivateButtons(){
        
        for var i:String in indicePreguntas {
            botones[i]!.enabled = true
            respuestas[i]!.textColor = UIColor.blackColor()
        }
        
    }
    
    func pintaPregunta (pagina:Int,ind:Int) {
        
        let letraPregunta = indicePreguntas[ind]
        
        if ind >= alternativasPregunta[pagina].count {
            botones[letraPregunta]!.hidden = true
            respuestas[letraPregunta]!.text = ""
            return
        }
        
        if misRespuestas[pagina][0] == "x" {
            respuestas[letraPregunta]!.text = alternativasPregunta[pagina][ind]
            botones[letraPregunta]!.hidden = false
            botones[letraPregunta]!.setImage(UIImage(named: indicePreguntas[ind].capitalizedString), forState: UIControlState.Normal)
        } else {
            if misRespuestas[pagina][0] == indicePreguntas[ind] {
                
                if misRespuestas[pagina][1] == "c" {
                    botones[letraPregunta]!.setImage(correcto, forState: UIControlState.Normal)
                    botones[letraPregunta]!.hidden = false
                    botones[letraPregunta]!.enabled = false
                    respuestas[letraPregunta]!.text = alternativasPregunta[pagina][ind]
                    respuestas[letraPregunta]!.textColor = verde
                } else {
                    botones[letraPregunta]!.setImage(incorrecto, forState: UIControlState.Normal)
                    botones[letraPregunta]!.hidden = false
                    botones[letraPregunta]!.enabled = false
                    respuestas[letraPregunta]!.text = alternativasPregunta[pagina][ind]
                    respuestas[letraPregunta]!.textColor = rojo
                }
        
        } else {
            
            respuestas[letraPregunta]!.text = alternativasPregunta[pagina][ind]
            botones[letraPregunta]!.enabled = false
            botones[letraPregunta]!.setImage(UIImage(named: indicePreguntas[ind].capitalizedString), forState: UIControlState.Normal)
            botones[letraPregunta]!.hidden = false
            }
        }
    }
     


    func comprobarRespuesta(laRespuesta:String) {
        
        if respuestaPregunta == laRespuesta {
            botones[laRespuesta]!.setImage(correcto, forState: UIControlState.Normal)
            respuestas[laRespuesta]!.textColor = verde
            misRespuestas[numPagina-1][0] = laRespuesta
            misRespuestas[numPagina-1][1] = "c"
            resultadoCorrecto(laRespuesta)
        }
        else {
            botones[laRespuesta]!.setImage(incorrecto, forState: UIControlState.Normal)
            respuestas[laRespuesta]!.textColor = rojo
            misRespuestas[numPagina-1][0] = laRespuesta
            misRespuestas[numPagina-1][1] = "i"
            resultadoIncorrecto(laRespuesta)
        }

    }
    func paginaInicial() {
        
        respuestasBuenas = 0
        numPagina = 1
        
        numeroPregunta.text = "\(numPagina)"
        numeroPuntos.text = "\(respuestasBuenas)"
        
        textoPregunta.text = preguntasExamen[numPagina][0]
        respuestaPregunta = preguntasExamen[numPagina][1]
        fotoImagen.image = UIImage(named: preguntasExamen[numPagina][2])
        
        misRespuestas = Array<Array<String>>()
        
        for var ii = 0 ; ii <= maxPaginas ; ii++ {
            misRespuestas.append(Array(count:2, repeatedValue:"x"))
        }
        reactivateButtons()
        nextButton.enabled = true
        bacKButton.enabled = false
        
        for var i:Int = 0; i < maxPreguntas; i++ {
            pintaPregunta(numPagina, ind: i)
        }
        
        numPagina++
    }
}

    


    



