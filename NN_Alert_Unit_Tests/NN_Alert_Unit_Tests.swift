//
//  NN_Alert_Unit_Tests.swift
//  NN_Alert_Unit_Tests
//
//  Created by Tran Khoa on 20/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import NN_Alert
class NN_Alert_Unit_Tests: QuickSpec {
    override func spec() {
        let action_1 = NN_Action_Sheet_Item(title:"action_1",id:"a_1",isCurrentSelected:true)
        let action_2 = NN_Action_Sheet_Item(title:"action_2",id:"a_2",isCurrentSelected:true)
        let action_3 = NN_Action_Sheet_Item(title:"action_3",id:"a_3")
        let action_4 = NN_Action_Sheet_Item(title:"action_4",id:"a_4")
        let action_5 = NN_Action_Sheet_Item(title:"action_5",id:"a_5")
        describe("INIT TESTS ") {
            context("CREATE NN_Action_Sheet_Items with 5 items 2 selected and 2 selectable") {
                it("should create the NN_Action_Sheet_Items correctly") {
                    
                    expect{
                        let items = try NN_Action_Sheet_Items([action_1,action_2,action_3,action_4,action_5],selectableCount:2)
                        expect(items.currentSelectedIndexes == [0,1]).to(be(true))
                        expect(items.items.count == 5).to(be(true))
                        return items
                        }.notTo(throwError())
                    
                }
            }
            context("CREATE NN_Action_Sheet_Items with 5 items 2 selected and 6 selectable") {
                it("should throw an error") {
                    expect{try NN_Action_Sheet_Items([action_1,action_2,action_3,action_4,action_5],selectableCount:6)}.to(throwError())
                }
            }
        }
    }
}
