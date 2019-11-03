//
//  TestFailure.swift
//  Fooding
//
//  Created by 최혜선 on 2019/11/03.
//  Copyright © 2019 jamie. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct TestFailure: Codable {
    let i2620: I2620
    
    enum CodingKeys: String, CodingKey {
        case i2620 = "I2620"
    }
}

// MARK: - I2620
struct I2620: Codable {
    let result: TestFailureResult
    let totalCount: String
    let row: [TestFailureRow]
    
    enum CodingKeys: String, CodingKey {
        case result = "RESULT"
        case totalCount = "total_count"
        case row
    }
}

// MARK: - Result
struct TestFailureResult: Codable {
    let msg, code: String
    
    enum CodingKeys: String, CodingKey {
        case msg = "MSG"
        case code = "CODE"
    }
}

// MARK: - Row
struct TestFailureRow: Codable {
    let frmlcunit, testanalsRslt, bsshnm, distbtmlmt: String
    let brcdno, rtrvldsuseSeq, cretDtm, mnfdt: String
    let prdtnm, stdrStnd, addr, testItmnm: String
    let insttNm, regstrTelno: String
    
    enum CodingKeys: String, CodingKey {
        case frmlcunit = "FRMLCUNIT"
        case testanalsRslt = "TESTANALS_RSLT"
        case bsshnm = "BSSHNM"
        case distbtmlmt = "DISTBTMLMT"
        case brcdno = "BRCDNO"
        case rtrvldsuseSeq = "RTRVLDSUSE_SEQ"
        case cretDtm = "CRET_DTM"
        case mnfdt = "MNFDT"
        case prdtnm = "PRDTNM"
        case stdrStnd = "STDR_STND"
        case addr = "ADDR"
        case testItmnm = "TEST_ITMNM"
        case insttNm = "INSTT_NM"
        case regstrTelno = "REGSTR_TELNO"
    }
}

extension TestFailureRow {
    var score: String {
        return "\(testanalsRslt) / \(stdrStnd)"
    }
}
