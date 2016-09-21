//
//  MatrixViewController.swift
//  Math system solver
//
//  Created by Denis Dobynda on 9/11/16.
//  Copyright © 2016 Denis Dobynda. All rights reserved.
//

import UIKit

class MatrixViewController: UIViewController, UITextFieldDelegate {

    var matrix = Matrix()
    var equals = Matrix()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        M11.delegate = self
        M12.delegate = self
        M13.delegate = self
        M14.delegate = self
        M21.delegate = self
        M22.delegate = self
        M23.delegate = self
        M24.delegate = self
        M31.delegate = self
        M32.delegate = self
        M33.delegate = self
        M34.delegate = self
        M41.delegate = self
        M42.delegate = self
        M43.delegate = self
        M44.delegate = self
        
        B1.delegate = self
        B2.delegate = self
        B3.delegate = self
        B4.delegate = self
        
        eps.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        setUpActionButton(UIButton())
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var outputTextField: UILabel!
    @IBOutlet weak var resultsTextField: UILabel!
    
    @IBOutlet weak var M11: UITextField!
    @IBOutlet weak var M12: UITextField!
    @IBOutlet weak var M13: UITextField!
    @IBOutlet weak var M14: UITextField!
    @IBOutlet weak var M21: UITextField!
    @IBOutlet weak var M22: UITextField!
    @IBOutlet weak var M23: UITextField!
    @IBOutlet weak var M24: UITextField!
    @IBOutlet weak var M31: UITextField!
    @IBOutlet weak var M32: UITextField!
    @IBOutlet weak var M33: UITextField!
    @IBOutlet weak var M34: UITextField!
    @IBOutlet weak var M41: UITextField!
    @IBOutlet weak var M42: UITextField!
    @IBOutlet weak var M43: UITextField!
    @IBOutlet weak var M44: UITextField!

    @IBOutlet weak var B1: UITextField!
    @IBOutlet weak var B2: UITextField!
    @IBOutlet weak var B3: UITextField!
    @IBOutlet weak var B4: UITextField!
    
    @IBOutlet weak var eps: UITextField!
    
    @IBAction func setUpActionButton(_ sender: UIButton)
    {
        var matrixToTransform: [[Double]] = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
        
        matrixToTransform[0][0] = Double((M11?.text!)!) ?? 0
        matrixToTransform[0][1] = Double((M12?.text!)!) ?? 0
        matrixToTransform[0][2] = Double((M13?.text!)!) ?? 0
        matrixToTransform[0][3] = Double((M14?.text!)!) ?? 0
        matrixToTransform[1][0] = Double((M21?.text!)!) ?? 0
        matrixToTransform[1][1] = Double((M22?.text!)!) ?? 0
        matrixToTransform[1][2] = Double((M23?.text!)!) ?? 0
        matrixToTransform[1][3] = Double((M24?.text!)!) ?? 0
        matrixToTransform[2][0] = Double((M31?.text!)!) ?? 0
        matrixToTransform[2][1] = Double((M32?.text!)!) ?? 0
        matrixToTransform[2][2] = Double((M33?.text!)!) ?? 0
        matrixToTransform[2][3] = Double((M34?.text!)!) ?? 0
        matrixToTransform[3][0] = Double((M41?.text!)!) ?? 0
        matrixToTransform[3][1] = Double((M42?.text!)!) ?? 0
        matrixToTransform[3][2] = Double((M43?.text!)!) ?? 0
        matrixToTransform[3][3] = Double((M44?.text!)!) ?? 0
        
        matrix.setMatrix(newMatrix: matrixToTransform, withSize: 4)
        
        var equalsMatrix: [Double] = [0,0,0,0]
        
        equalsMatrix[0] = Double((B1?.text!)!) ?? 0
        equalsMatrix[1] = Double((B2?.text!)!) ?? 0
        equalsMatrix[2] = Double((B3?.text!)!) ?? 0
        equalsMatrix[3] = Double((B4?.text!)!) ?? 0
        
        let EPS: Double = Double((eps?.text!)!) ?? 0.0
        
        matrix.setEpsilon(newValue: EPS)
        
        if !matrix.setEquals(newVector: equalsMatrix)
        {
            //handle
        }
        
        //send
        
        outputTextField?.text = matrix.getMatrixInString()
        
        if matrix.tryToSolve() {
            resultsTextField?.text = matrix.getResultInString()
        } else {
            resultsTextField?.text = "We have some problems here...\nSet up Matrixes and epsilpon\n(for Gausse >=0.2)"
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
