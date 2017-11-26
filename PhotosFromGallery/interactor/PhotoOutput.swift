import Foundation
import Photos

protocol PhotoOutput: class {
    func receivePhotoData(photos: [PHAsset])
}
