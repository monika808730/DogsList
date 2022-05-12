import UIKit
import SDWebImage

class ListCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func displayResult(result:DogsListModel){
        nameLabel.text = result.name
        imgView.sd_setImage(with:URL(string: result.imgURL))
    }

}
