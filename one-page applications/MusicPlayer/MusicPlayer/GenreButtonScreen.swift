import UIKit
import MediaPlayer

class GenreButtonScreen: UIViewController {
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GenreButtonTap(_ sender: UIButton) {
        MPMediaLibrary.requestAuthorization{ (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                           self.playGenre(genre: sender.currentTitle!)
                        }
            }
        }
    }
    
    @IBAction func StopButtonTapped(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    
    func playGenre(genre: String) {
        musicPlayer.stop()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        let query = MPMediaQuery()
        query.addFilterPredicate(predicate)
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
    }
}
