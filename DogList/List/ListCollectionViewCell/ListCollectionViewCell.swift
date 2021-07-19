import UIKit
import SDWebImage

class ListCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func displayResult(result:JSONDictionary){
        nameLabel.text = result["name"] as? String ?? ""
        if let imageDict = result["image"] as? JSONDictionary{
            if let imageURL = imageDict["url"] as? String{
                imgView.sd_setImage(with:URL(string: imageURL))
            }
        }
    }

}
