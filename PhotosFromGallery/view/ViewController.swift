import UIKit
import Photos

class ViewController: UIViewController,PhotoOutput {
    var images = [PHAsset]()
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let interactor = PhotoInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        interactor.delegate = self
        showCameraPermissionPopup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func receivePhotoData(photos: [PHAsset]) {
        images = photos
        self.table.reloadData()
        indicator.isHidden = true
    }
    
    private func showCameraPermissionPopup() {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            self.indicator.startAnimating()
            self.interactor.providePhotogData()
        } else {
            PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus)in
                switch status{
                case .denied:
                    self.indicator.isHidden = true
                    self.showErrorDialog(msg: "Access denied photos and camera")
                    break
                case .authorized:
                    self.indicator.startAnimating()
                    self.interactor.providePhotogData()
                    break
                default:
                    break
                }
            })
        }
    }
    
    private func showErrorDialog(msg: String){
        let alert = UIAlertController(title: "Error", message: msg , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            action -> Void in
            alert.dismiss(animated: false, completion: nil)
        })
        present(alert, animated: false, completion: nil)
    }
}

