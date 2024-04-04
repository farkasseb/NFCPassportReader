//
//  DataGroup13.swift
//  FaceKomSDK
//
//  Created by Francsics Ádám on 2023. 02. 20..
//

import Foundation
import NFCPassportReader

@available(iOS 13, macOS 10.15, *)
public class DataGroup13: DataGroup {
    
    public private(set) var optionalData : String?
    public override var datagroupType: DataGroupId { .DG13 }


    required init( _ data : [UInt8] ) throws {
        try super.init(data)
    }
    
    public override func parse(_ data: [UInt8]) throws {
        var tag = try getNextTag()
        if tag != 0x5C {
            throw NFCPassportReaderError.InvalidResponse(dataGroupId: .DG13, expectedTag: 0x5C, actualTag: tag)
        }
        
        // Skip the taglist - ideally we would check this but...
        let _ = try getNextValue()
        
        repeat {
            tag = try getNextTag()
            let val = try getNextValue()
            
            if tag == 0x5F5B {
                optionalData = String( bytes:val, encoding:.utf8)
            }
        } while pos < data.count
    }
}

let parserCongig = ParserConfig { name, tag, dataClass in
    if name == "DG13" && dataClass == NotImplementedDG.self {
        return DataGroup13.self
    }
    return nil
}
