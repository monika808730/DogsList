
import UIKit
import SDWebImage

class DetailsVC: UITableViewController
{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var breedForLabel: UILabel!
    @IBOutlet weak var breedGroupLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    
    var details = JSONDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

//    MARK:- SetupUI as per Response
    func setupUI(){
        titleLabel.text = details["name"] as? String ?? ""
        temperamentLabel.text = details["temperament"] as? String ?? "N/A"
        breedForLabel.text = details["bred_for"] as? String ?? "N/A"
        breedGroupLabel.text = details["breed_group"] as? String ?? "N/A"
        lifeSpanLabel.text = details["life_span"] as? String ?? "N/A"
        
        if let heightDict = details["height"] as? JSONDictionary{
            let metric = heightDict["metric"] as? String ?? "N/A"
            let imperial = heightDict["imperial"] as? String ?? "N/A"
            
            heightLabel.text = "Metric : \(metric) \nImperial : \(imperial)"
        }
        
        if let weightDict = details["weight"] as? JSONDictionary{
            let metric = weightDict["metric"] as? String ?? "N/A"
            let imperial = weightDict["imperial"] as? String ?? "N/A"
            
            weightLabel.text = "Metric : \(metric) \nImperial : \(imperial)"
        }
        
        if let imageDict = details["image"] as? JSONDictionary{
            if let imageURL = imageDict["url"] as? String{
                imgView.sd_setImage(with:URL(string: imageURL))
            }
        }
    }
}
