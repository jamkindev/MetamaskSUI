//
//  SideMenuView.swift
//  MetamaskSUI
//
//  Created by jamkin on 2022/7/6.
//

import SwiftUI

private struct Constants {
    static let naviVerticalPadding: CGFloat = 10
    static let menuRViewW: CGFloat = 90
    static let tabBtnFont: CGFloat = 15
    static let borderW: CGFloat = 2
    
    static let iconImgName: String = "fox"
    static let iconStr: String = "METAMASK"
    static let avatarImgName: String = "fox"
    static let btnSendTittle: String = "发送"
    static let btnBuyTittle: String = "充值"
    static let btnSendImgName: String = "arrow.up.forward"
    static let btnBuyImgName: String = "arrow.down.to.line"
    static let btnBrowTittle: String = "浏览器"
    static let btnBrowImgName: String = "network"
    static let btnPurseTittle: String = "钱包"
    static let btnPurseImgName: String = "filemenu.and.selection"
    static let btnActivTittle: String = "活动"
    static let btnActivImgName: String = "list.bullet"
    static let btnSharAdrTittle: String = "共享我的公共地址"
    static let btnSharAdrImgName: String = "square.and.arrow.up"
    static let btnCheckTittle: String = "在Etherscan上查看"
    static let btnCheckImgName: String = "eye"
    static let btnSetTittle: String = "设置"
    static let btnSetImgName: String = "gearshape"
    static let btnHelpTittle: String = "获取帮助"
    static let btnHelpImgName: String = "bubble.left.and.bubble.right.fill"
    static let btnRequTittle: String = "请求功能"
    static let btnRequImgName: String = "bubble.left"
    static let btnLogoutTittle: String = "注销"
    static let btnLogoutImgName: String = "arrow.right.square"
}

struct SideMenuView: View {
    @Binding var showMenu : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(Constants.iconImgName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                Text(Constants.iconStr)
                    .font(.title2.bold())
            }
            .padding(.leading)
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 14) {
                Image(Constants.avatarImgName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .stroke(.blue, lineWidth: 2)
                    )
                
                Text("Account1")
                    .font(.title2.bold())
                Text("$0")
                    .font(.callout)
                Text("0x12345678")
                    .font(.footnote)
                
            }
            .padding(.top)
            .padding(.horizontal)
            .padding(.leading,-5)
            .padding(.bottom)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Divider()
                    
                    HStack {
                        
                        BorderButton(title: Constants.btnSendTittle, image: Constants.btnSendImgName)
                        
                        BorderButton(title: Constants.btnBuyTittle, image: Constants.btnBuyImgName)
                    }
                    .padding(.top,10)
                    .padding(.bottom,10)
                    
                }
                VStack {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TabButton(title: Constants.btnBrowTittle, image: Constants.btnBrowImgName)
                        TabButton(title: Constants.btnPurseTittle, image: Constants.btnPurseImgName)
                        TabButton(title: Constants.btnActivTittle, image: Constants.btnActivImgName)
                        
                    }
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TabButton(title: Constants.btnSharAdrTittle, image: Constants.btnSharAdrImgName)
                        TabButton(title: Constants.btnCheckTittle, image: Constants.btnCheckImgName)
                    }
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TabButton(title: Constants.btnSetTittle, image: Constants.btnSetImgName)
                        TabButton(title: Constants.btnHelpTittle, image: Constants.btnHelpImgName)
                        TabButton(title: Constants.btnRequTittle, image: Constants.btnRequImgName)
                        TabButton(title: Constants.btnLogoutTittle, image: Constants.btnLogoutImgName)
                    }
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(.primary)
                }
            }
        }
        .padding(.top)
        .frame(maxWidth: .infinity,alignment: .leading)
        //        Max width..
        .frame(width: getRect().width - Constants.menuRViewW)
        .frame(maxHeight: .infinity)
        .background(
            Color.primary
                .opacity(0.04)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    //                    Tab Buttons
    @ViewBuilder
    func TabButton(title : String, image : String) -> some View {
        
        //        For navigation..
        //        Simple replace button with Navigation Links....
        NavigationLink {
            Text("\(title) View")
                .navigationTitle(title)
        } label: {
            HStack(spacing: 14){
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity,alignment: .leading)
            .font(Font.system(size: Constants.tabBtnFont))
            
        }
    }
    
    @ViewBuilder
    func BorderButton(title: String, image: String) -> some View {
        Button(action: {}) {
            Image(systemName: image)
            Text(title)
                .font(Font.system(size: 15))
        }
        .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
        .overlay(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .stroke(.blue, lineWidth: Constants.borderW)
        )
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
