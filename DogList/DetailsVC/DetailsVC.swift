
import UIKit
import SDWebImageSwiftUI

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
    
    var details = [DogsListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

//    MARK:- SetupUI as per Response
    func setupUI(){
        titleLabel.text = details.first?.name ?? ""
        temperamentLabel.text = details.first?.temperament ?? "N/A"
        breedForLabel.text = details.first?.bred_for ?? "N/A"
        breedGroupLabel.text = details.first?.breed_group ?? "N/A"
        lifeSpanLabel.text = details.first?.life_span ?? "N/A"
        heightLabel.text = details.first?.height_metric_imperial ?? "N/A"
        weightLabel.text = details.first?.weight_metric_imperial ?? "N/A"
        imgView.sd_setImage(with:URL(string: details.first?.imgURL ?? ""))
    }
}
