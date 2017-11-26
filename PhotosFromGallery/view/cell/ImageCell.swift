import UIKit
import Photos

class ImageCell: UITableViewCell {
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var md5: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var preview: UIImageView!
    
    var model:PHAsset?{
        didSet{
            size.text = model?.size
            md5.text = model?.md5
            name.text = model?.filename
            preview.image = model?.image
        }
    }
}
