//
//  ViewController.swift
//  CalculadoraBasica
//
//  Created by Jose Carlos Corona Bautista on 02/03/23.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: -Variables de botones
    
    //Resultado
    @IBOutlet weak var resultLabel: UILabel!
    
    //Numeros
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    
    //Operaciones
    @IBOutlet weak var operacionAC: UIButton!
    @IBOutlet weak var operacionResultado: UIButton!
    @IBOutlet weak var operacionMas: UIButton!
    @IBOutlet weak var operacionMenos: UIButton!
    @IBOutlet weak var operacionMultiplicar: UIButton!
    @IBOutlet weak var operacionDividir: UIButton!
    
    //MARK: -Variables
    
    private var total:Double = 0 //total
    private var temp:Double = 0 //valor de pantalla
    private var operando = false //indica si esta seleccionada una operacion
    private var decimal = false
    private var operacion: tipoOperacion = .none //operacion actual
    
    //MARK: -Contantes
    
    private let kDecimalSeparador = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kTotal = "total"
    
    private enum tipoOperacion{
        case none, suma, resta, multiplicacion, division
    }
    
    private let imprimirFormato: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    //MARK: -Ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()

        total = UserDefaults.standard.double(forKey: kTotal)
        
        resultado()
    }

    
    //MARK: -Operaciones
    
    @IBAction func ACAction(_ sender: Any) {
        limpiar()
        print("limpio")
    }
    
    @IBAction func resultadoAction(_ sender: Any) {
        resultado()
        print("resuelto")
    }
    
    @IBAction func sumaAction(_ sender: Any) {
        if operacion != .none{
            resultado()
        }
        
        operando = true
        operacion = .suma
        
        print("sumando")
    }
    
    @IBAction func restaAction(_ sender: Any) {
        if operacion != .none{
            resultado()
        }
        
        operando = true
        operacion = .resta
        
        print("restando")
    }
    
    @IBAction func multiplicacionAction(_ sender: Any) {
        if operacion != .none{
            resultado()
        }
        
        operando = true
        operacion = .multiplicacion
        
        print("multiplicando")
    }
    
    @IBAction func divisionAction(_ sender: Any) {
        if operacion != .none{
            resultado()
        }
        
        operando = true
        operacion = .division
        
        print("dividiendo")
    }
    
    
    @IBAction func numerosAction(_ sender: UIButton) {
        operacionAC.setTitle("C", for: .normal)
        var currentTemp = imprimirFormato .string(from: NSNumber(value: temp))!
        if !operando && currentTemp.count >= kMaxLength{
            return
        }
        
        if operando{
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operando = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = imprimirFormato.string(from: NSNumber(value: temp))
        
    }
    
    
    private func limpiar(){
        operacion = .none
        operacionAC.setTitle("AC", for: .normal)
        if temp != 0{
            temp = 0
            resultLabel.text = "0"
        }else{
            total = 0
            resultado()
        }
    }
    
    private func resultado(){
        switch operacion {
        case .none:
            break
        case .suma:
            total = total+temp
            break
        case .resta:
            total = total-temp
            break
        case .multiplicacion:
            total = total*temp
            break
        case .division:
            total = total/temp
            break
        }
        
        resultLabel.text = imprimirFormato.string(from: NSNumber(value: total))
        
        operacion = .none
        UserDefaults.standard.set(total, forKey: kTotal)
        print("total: \(total)")
    }
    
}
