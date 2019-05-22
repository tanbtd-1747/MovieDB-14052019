//
//  VideoViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct VideoViewModel {
    let movieDetail: MovieDetail
}

extension VideoViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let video: Driver<Video>
    }
    
    func transform(_ input: VideoViewModel.Input) -> VideoViewModel.Output {
        let video = input.loadTrigger
            .map {
                self.movieDetail.videos.first
            }
            .unwrap()
        
        return Output(
            video: video
        )
    }
}
