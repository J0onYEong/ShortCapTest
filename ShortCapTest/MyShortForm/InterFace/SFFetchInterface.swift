//
//  SFFetchInterFace.swift
//  ShortCapTest
//
//  Created by 최준영 on 3/3/24.
//

import Foundation

enum SFFetcherError: Error {
    
    case errorInFetchingProcess
}

protocol SFFetcher {
    
    func getSummaryContentModels(completion: @escaping (Result<SummaryContentListModel, SFFetcherError>) -> Void)
    
    func updateLocalSummaryContentWith(model: SummaryContentModel)
    
    func moveFileDataToCoreData()
}
