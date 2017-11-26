import Foundation
import Photos
import CommonCryptoModule

extension PHAsset {
    var md5: String?{
        let dataMD5 = MD5(string: self.hash.description)
        return dataMD5.map { String(format: "%02hhx", $0) }.joined()
    }
    
    var size: String?{
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        var size: Float = 0
        manager.requestImageData(for: self, options: option, resultHandler: {
            (data, _,_, _) in
            let imageSize = Float((data?.count)!)
            size = imageSize/(1024*1024)
        })
        size = roundf(100*size)/100
        return "\(size)/mb"
    }
    
    var image: UIImage?{
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    var filename: String? {
        var fname:String?
        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResources(for: self)
            if let resource = resources.first {
                fname = resource.originalFilename
            }
        }
        if fname == nil {
            fname = self.value(forKey: "filename") as? String
        }
        return fname
    }
    
    private func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
}

