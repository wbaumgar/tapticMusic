//
//  homeViewController.swift
//  tapticMusic
//
//  Created by William Baumgardner on 2/4/20.
//  Copyright © 2020 William Baumgardner. All rights reserved.
//

import UIKit
import MediaPlayer
import SnapKit
import AVFoundation
import PINRemoteImage

class homeViewController: UIViewController, MPMediaPickerControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    let musicPlayer  = MPMusicPlayerApplicationController.applicationMusicPlayer
    let musicQueue   = UITableView()
    let queuedSongs  = [String]()
    
    var playing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        musicPlayer.setQueue(with: .songs())
        setupView()
        view.backgroundColor = .systemPink
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        setupNavBar()
        
        let playButton = UIButton()
        view.addSubview(playButton)
        playButton.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view.snp.center)
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
        playButton.backgroundColor = .purple
        playButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        
        view.addSubview(musicQueue)
        musicQueue.backgroundColor = .white
        musicQueue.dataSource      = self
        musicQueue.delegate        = self
        musicQueue.rowHeight       = 120
        musicQueue.register(queuedSongTableViewCell.self, forCellReuseIdentifier: "queuedSong")
        musicQueue.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectSong))
    }
    
    @objc func playPause(){
        if playing {
            musicPlayer.pause()
        } else {
            musicPlayer.play()
        }
        playing = !playing
    }
    
    @objc func selectSong(){
        let controller = MPMediaPickerController(mediaTypes: .music)
        controller.allowsPickingMultipleItems = false
        controller.popoverPresentationController?.sourceView = self.view
        controller.delegate = self
        present(controller,animated: true)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        musicPlayer.setQueue(with: mediaItemCollection)
        mediaPicker.dismiss(animated: true, completion: nil)
    }

    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "queuedSong", for: indexPath) as! queuedSongTableViewCell
        cell.albumnCover.pin_setImage(from: URL(string:"https://blog.spoongraphics.co.uk/wp-content/uploads/2017/01/thumbnail-2.jpg"))
        cell.songTitle.text = "awake my soul please"
        cell.artist.text = "myself"
        return cell
    }

}
