//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Subham on 2/4/17.
//  Copyright © 2017 Subham. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var moovView: UIView!
    @IBOutlet weak var loadingLbl: UILabel!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var baseLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.moovView.isHidden = true
        self.upperView.backgroundColor = UIColor.clear
        self.moovView.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.moovView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect)
        blurEffectView2.frame = self.upperView.bounds
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.moovView.insertSubview(blurEffectView, at: 0)
        self.upperView.insertSubview(blurEffectView2, at: 0)
        self.activity.startAnimating()
        self.activity.hidesWhenStopped = true

        nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after downloading
            self.updateUI()
            self.activity.stopAnimating()
            self.upperView.isHidden = true
        }
        
        
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        heightLbl.text = pokemon.height
        typeLbl.text = pokemon.type
        defenceLbl.text = pokemon.defense
        pokedexLbl.text = "\(pokemon.pokedexId)"
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            evoLbl.text = str
        }
        
        baseLbl.text = pokemon.attack
        weightLbl.text = pokemon.weight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentPressed(_ sender: Any) {
        switch segment.selectedSegmentIndex {
        case 0:
            self.moovView.isHidden = true
        case 1:
            self.moovView.isHidden = false
        default:
            break
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
