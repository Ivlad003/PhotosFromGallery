import UIKit
import Photos
class PhotoInteractor: PhotoProvider {
    var delegate: PhotoOutput?
    func providePhotogData() {
        var images = [PHAsset]()
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects({ (object, count, stop) in
            images.append(object)
        })
        images.reverse()
        if let _delegate = delegate{
            _delegate.receivePhotoData(photos: images)
        }
    }
}
