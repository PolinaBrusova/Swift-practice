import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalPriceLbl: UILabel!
    
    @IBOutlet weak var PriceTax: UITextField!
    @IBOutlet weak var salesTaxTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalPriceLbl.text = ""
    }

    @IBAction func calculateTotalPrice(_ sender: Any) {
        let price = Double(PriceTax.text!)!
        let salesTax = Double(salesTaxTxt.text!)!
        
        let totalsalesTax = price * salesTax
        let totalPrice = price + totalsalesTax
        totalPriceLbl.text = "$\(totalPrice)"
    }
    
}

