//
//  APIType.swift
//  Fooding
//
//  Created by 최혜선 on 07/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import Foundation

enum FoodSafeAPIType: String {
    /// 과대광고 모니터링 적발 및 조치
    case exAd = "I0500"
    /// 검사부적합
    case nonconformity = "I2620"
    /// 회수.판매중지 정보
    case recall = "I0490"
    /// 해외직구 위해식품 차단정보
    case overseas = "I2715"
    
    var value: String {
        return self.rawValue
    }
}
