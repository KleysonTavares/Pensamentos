//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Kleyson on 31/03/2021.
//  Copyright © 2021 Kleyson Tavares. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var imageViewPhotoBackground: UIImageView!
    @IBOutlet weak var labelQuote: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var constraintsTopQuote: NSLayoutConstraint!
    
    let config = Configuration.shared
    
    let quotesManager = QuotesManager()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //chama o observer
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView() // o que fazer quando o oberver for notificado
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        labelQuote.textColor = config.colorScheme == 0 ? .black : .white
        labelAuthor.textColor = config.colorScheme == 0 ? UIColor(red: 192.0/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0) : .yellow
        prepareQuote()
        
    }
    
    func prepareQuote() {
        timer.invalidate() //invalida a execuçao anterior do do metodo se a classe for chamada mais de uma vez
        if config.autoRefresh{
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true, block: { (timer) in
                self.showRandomQuote()
            }) }
        showRandomQuote()
    }
    
    func showRandomQuote() {
        let quote = quotesManager.getRandomQuote()
        labelQuote.text = quote.quote
        labelAuthor.text = quote.author
        imageViewPhoto.image = UIImage(named: quote.image)
        imageViewPhotoBackground.image = imageViewPhoto.image
        
        labelQuote.alpha = 0.0
        labelAuthor.alpha = 0.0
        imageViewPhoto.alpha = 0.0
        imageViewPhotoBackground.alpha = 0.0
        constraintsTopQuote.constant = 50
        view.layoutIfNeeded()//como estou modificando os valores da constraint, preciso atualizar o layout da view
        
        UIView.animate(withDuration: 2.5){
            self.labelQuote.alpha = 1.0
            self.labelAuthor.alpha = 1.0
            self.imageViewPhoto.alpha = 1.0
            self.imageViewPhotoBackground.alpha = 0.25
            self.constraintsTopQuote.constant = 10
            self.view.layoutIfNeeded()
        }
    }
}
