//
//  SecondGameViewController.swift
//  Game2
//
//  Created by Мас on 24.02.2021.
//

import UIKit

class SecondGameViewController: UIViewController {

    @IBOutlet weak var currentPoints: UILabel!
    @IBOutlet weak var myCard: UILabel!
    @IBOutlet weak var leftCard: UIButton!
    @IBOutlet weak var rightCard: UIButton!
    
//Declare and assign constants that indicate maximum and minimum values that our card may have
    let maxValue:Int = 21
    let minValue:Int = 0
 
    //   We save the images in constants to modify them later
    let greenCardImg = UIImage(named: "greenCard")
    let redCardImg = UIImage(named: "redCard")
    let freePointsImg = UIImage(named: "freePoints")
    
    //We keep the initial score at 0
    var currentPointsValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewValues()
    }
    // Action of the letter / button on the left, calls the animation function and functionality when pressed
    @IBAction func leftButtonAction(_ sender: Any) {
        fade_in(card: leftCard)
        fade_out(card: leftCard)
        onCardClick(card: leftCard)
    }
    // Action of the letter / button on the right, calls the animation function and functionality when pressed
    @IBAction func rightButtonAction(_ sender: UIButton) {
        fade_in(card: rightCard)
        fade_out(card: rightCard)
        onCardClick(card: rightCard)
    }
    
    // Returns random num between -9 and 9
    func getRandomNumber() -> Int {
        return Int.random(in: -9..<9)
    }
    
    /* - Assigns new values to the cards, checks if there are values saved in userdefaults, if the data has been loaded and in case of being empty it generates new random as well as checking and assigning a viable beginning based on the two upper cards.
          - Reset the score to 0
          - Call the functions to place correct image and title
          - "Save Game"
          */
    
    func setNewValues(){

        let rightNewValue:Int
        let leftNewValue:Int
        
        if let points = UserDefaults.standard.string(forKey: "points") {
            currentPointsValue = Int(points)!
            rightNewValue = Int(loadState(keyName: "rightCard"))!
            leftNewValue = Int(loadState(keyName: "leftCard"))!
            myCard.text = loadState(keyName: "currentCard")
        }else{
            rightNewValue = getRandomNumber()
            leftNewValue = getRandomNumber()
            setViableStart(rightValue: rightNewValue, leftValue: leftNewValue)
            currentPointsValue = 0
        }
        
        setProperImage(card: rightCard, newValue: rightNewValue)
        setProperImage(card: leftCard, newValue: leftNewValue)
        
        setProperTitle(card: rightCard, value:rightNewValue)
        setProperTitle(card: leftCard, value:leftNewValue)
        
        generalSave()
        
        currentPoints.text = Int(currentPointsValue).description + " pts."
    }
    
    //Add the value of our letter to that of the chosen one and assign it to the label. Returns the result of the sum
    func updateMyCard(cardValue: Int)->Int{

        let currentScoreInt: Int = Int (myCard.text!.description)!
        let result: Int = currentScoreInt + cardValue
        myCard.text = result.description
        
        return result
    }
    
    /* Check the status of the game
          In case the value of our card exceeds the ranges, it checks if it has been the best score, if it is, it is saved in the userdefaults.
          If it has gone out of the values it will also redirect to another screen, it will erase the userdefaults of score and it will generate new values for the cards.
         
          If it is still within the values, it adds a score to the total and assigns it to the label in addition to "save game".
          */
    func checkState(myCard:Int) {
        
        if myCard > maxValue || myCard < minValue {
            
            if isBestScore(){
                saveState(keyName: "bestScore", value: currentPointsValue.description)
            }
            performSegue(withIdentifier: "lostGame", sender: nil)
            removeState(keyName: "points")
            setNewValues()
        }
        else{
            currentPointsValue += givePoints(percentage: calculatePercentage(myCard: myCard),score: myCard)
            generalSave()
            currentPoints.text = currentPointsValue.description + " pts."
        }
    }
   
    // Calculate and return the base percentage to the value of our card and the maximum possible (maxvalue = 21)
         // Receive the value of our card
    func calculatePercentage(myCard:Int)->Float{
        return Float(myCard) * 100 / Float(maxValue)
    }
    
    // Depending on the percentage in which the value of my card is found, the score to receive will be higher
         // More points are received when 0 and 21 than in the average values, for example 10.
         // Receive the percentage value
         // Returns score
    
    
    func givePoints(percentage:Float, score:Int)->Int{
        
        let lowestPoints: Int = 120
        let okayPoints: Int = 200
        let nicestPoints: Int = 500
        if percentage > 25 && percentage < 75{
            return lowestPoints
        }else if percentage == 0 || percentage == 100{
            return nicestPoints
            
        }
        else{
            return okayPoints
        }
    }
    
    // Check the value of the two upper cards to determine what will be the minimum or maximum viable value so that the start of the game is possible, so that if it is not, it generates a number for my card that is within the new assigned range .
         // If viable, it will generate a random number within the standard range
    
    func setViableStart(rightValue:Int, leftValue:Int){
        
        if(rightValue > minValue && leftValue > minValue){
            
            let maxPossible = maxValue - max(rightValue, leftValue)
            myCard.text = Int.random(in: minValue..<maxPossible).description
            
        }else if(rightValue < minValue && leftValue < minValue){
            
            let minPossible = minValue - min(rightValue, leftValue)
            myCard.text = Int.random(in: minPossible..<maxValue).description
            
        }else{
            myCard.text = Int.random(in: minValue..<maxValue).description
        }
    }
    
    // Receive key name and value to save game
    func saveState(keyName: String, value:String){
        
        UserDefaults.standard.set(value, forKey: keyName)
    }
    // General saving of all variables
    func generalSave(){
        
        saveState(keyName: "points", value: currentPointsValue.description)
        saveState(keyName: "rightCard", value: getCardValue(card: rightCard).description)
        saveState(keyName: "leftCard", value: getCardValue(card: leftCard).description)
        saveState(keyName: "currentCard", value: myCard.text!.description)
        
    }
    
    // Returns the value stored in userdefaults depending on the key name passed by parameter to load game
    func loadState(keyName:String) -> String{
        return UserDefaults.standard.string(forKey: keyName)!
    }
    // Delete the key in user defaults from the key received by parameter
    func removeState(keyName: String) {
        UserDefaults.standard.removeObject(forKey: keyName)
    }
    
    // Assign the image due based on the value of the parameter to the button also received in parameter
    func setProperImage(card: UIButton, newValue:Int){
        
        if newValue > 0{
            card.setBackgroundImage(greenCardImg, for: .normal)
        }else if newValue == 0{
            card.setBackgroundImage(freePointsImg, for: .normal)
        }else{
            card.setBackgroundImage(redCardImg, for: .normal)
        }
    }
    
    // Assign the title / value to the button, both passed by parameters, if it is 0 it will have no value since the letter will be the "free points"
    func setProperTitle(card: UIButton, value:Int){
        
        if(value != 0){
            card.setTitle(value.description, for: .normal)
        }else{
            card.setTitle("", for: .normal)
        }
        
    }
    
    // Returns the value of the letter received by param, checking first if it is empty, if it is, this will be 0
    func getCardValue(card: UIButton) -> Int{
        
        if !card.title(for: .normal)!.description.isEmpty {
            return Int (card.title(for: .normal)!.description)!
        }else{
            return 0
        }
        
    }
    /* It will serve to execute the functionality when pressing the letters
             - Collect the value of the card
             - Collect the sum of the two
             - Generate random number
             - Place the appropriate image and title
             - check the status of the game
          */
    
    func onCardClick(card:UIButton){
        
        let cardValue: Int = getCardValue(card: card)
        
        let myCard:Int = updateMyCard(cardValue: cardValue)
        
        let newRandomValue = getRandomNumber()
        
        setProperImage(card: card, newValue: newRandomValue)
        
        setProperTitle(card: card, value:newRandomValue)
        
        checkState(myCard: myCard)
        
    }
    
    // Check if this last score has been the maximum score based on the value of the last saved
    func isBestScore() -> Bool{
        
        if let bestScore = UserDefaults.standard.string(forKey: "bestScore"){
            if Int(bestScore)! < currentPointsValue{
                return true
            }else{
                return false
            }
        }else{
            return true
        }
        
    }
    
    // Animation fade in
    func fade_in(card:UIButton) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut,animations: {
            card.alpha = 0.0
        },completion: nil)
    }
    
    // Animation fade out
    func fade_out(card:UIButton) {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            card.alpha = 1.0
        },completion: nil)
    }


}
