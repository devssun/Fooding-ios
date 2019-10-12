//
//  File.swift
//  Fooding
//
//  Created by 최혜선 on 07/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Recall: Codable {
    let i0490: I0490
    
    enum CodingKeys: String, CodingKey {
        case i0490 = "I0490"
    }
}

// MARK: - I0490
struct I0490: Codable {
    let result: Result
    let totalCount: String
    let row: [Row]
    
    enum CodingKeys: String, CodingKey {
        case result = "RESULT"
        case totalCount = "total_count"
        case row
    }
}

// MARK: - Result
struct Result: Codable {
    let msg, code: String
    
    enum CodingKeys: String, CodingKey {
        case msg = "MSG"
        case code = "CODE"
    }
}

// MARK: - Row
struct Row: Codable {
    let prdlstCD, frmlcunit, rtrvlGrdcdNm, bsshnm: String
    let distbtmlmt, rtrvlplandocRtrvlmthd, brcdno, rtrvldsuseSeq: String
    let cretDtm, prdlstReportNo, mnfdt, rtrvlprvns: String
    let prdtnm, prcscitypointTelno, addr: String
    let imgFilePath: String
    let prdlstType: String
    
    enum CodingKeys: String, CodingKey {
        case prdlstCD = "PRDLST_CD"
        case frmlcunit = "FRMLCUNIT"
        case rtrvlGrdcdNm = "RTRVL_GRDCD_NM"
        case bsshnm = "BSSHNM"
        case distbtmlmt = "DISTBTMLMT"
        case rtrvlplandocRtrvlmthd = "RTRVLPLANDOC_RTRVLMTHD"
        case brcdno = "BRCDNO"
        case rtrvldsuseSeq = "RTRVLDSUSE_SEQ"
        case cretDtm = "CRET_DTM"
        case prdlstReportNo = "PRDLST_REPORT_NO"
        case mnfdt = "MNFDT"
        case rtrvlprvns = "RTRVLPRVNS"
        case prdtnm = "PRDTNM"
        case prcscitypointTelno = "PRCSCITYPOINT_TELNO"
        case addr = "ADDR"
        case imgFilePath = "IMG_FILE_PATH"
        case prdlstType = "PRDLST_TYPE"
    }
}

extension Row {
    var imageData: Data {
        let productThumbnail = imgFilePath.contains(",") ? imgFilePath.components(separatedBy: ",")[0] : imgFilePath
        if let URL = URL(string: productThumbnail), let data = try? Data(contentsOf: URL) {
            return data
        }
        return Data()
    }
}
