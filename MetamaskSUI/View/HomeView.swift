//
//  HomeView.swift
//  MetamaskSUI
//
//  Created by jamkin on 2022/7/6.
//

import SwiftUI

private struct Constants {
    static let menuImgName: String = "slider.horizontal.3"
    static let cameraImgName: String = "camera.viewfinder"
    static let purseStr: String = "钱包"
    static let naviCenterImgName: String = "title_green"
    static let naviCenterTittle: String = "Ethereum Main Network"
    static let avatarDefImgName: String = "questionmark.circle.fill"
    static let btnReceptTittle: String = "接收"
    static let btnReceptImgName: String = "arrow.down.to.line"
    static let btnBuyTittle: String = "购买"
    static let btnBuyImgName: String = "earbuds.case"
    static let btnSendTittle: String = "发送"
    static let btnSendImgName: String = "arrow.up.forward"
    static let btnExchangeTittle: String = "交换"
    static let btnExchangeImgName: String = "arrow.2.squarepath"
    static let segmMoneyTittle: String = "代币"
    static let segmCollectTittle: String = "收藏品"
    static let segmVCollectTittle: String = "尚无NFT"
    static let moneyVImgName: String = "eth-logo"
    static let moneyVArrImgName: String = "chevron.right"
    
    static let naviVerticalPadding: CGFloat = 10
    static let naviCenterTFont: CGFloat = 10
    static let refrHeadH: CGFloat = 70
    static let avatarDefImgBorW: CGFloat = 2
}
struct HomeView: View {
    @Binding var showMenu : Bool
    @ObservedObject var model = Model()
    @Binding var showKeyDetail: Bool
    
    var body: some View {
        VStack{
            
            VStack(spacing: 0) {
                HStack{
                    Button {
                        withAnimation{showMenu.toggle()}
                    } label: {
                        Image(systemName: Constants.menuImgName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 35)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation{
                            self.showKeyDetail.toggle()
                        }
                    } label: {
                        Image(systemName: Constants.cameraImgName)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        //                            .foregroundColor(.primary)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.vertical,Constants.naviVerticalPadding)
                .fullScreenCover(isPresented: $showKeyDetail, content: {
                    //全屏模式
                    CameraViewController()           .edgesIgnoringSafeArea(.top)
                })
                
            }
            .overlay(
                VStack(spacing: 0) {
                    Text(Constants.purseStr)
                    Button(action: {}) {
                        Image(Constants.naviCenterImgName)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
                        Text(Constants.naviCenterTittle)
                            .font(Font.system(size: Constants.naviCenterTFont))
                            .foregroundColor(.primary)
                    }
                    
                    Text("")
                    
                }
            )
            
            Spacer()
            
            
            RefreshableScrollView(height: Constants.refrHeadH, refreshing: self.$model.loading) {
                
                HomeTableView(homeViewModel: self.model.homeViewModel).background(Color(UIColor.systemBackground))
                
            }.background(Color(UIColor.white))
        }
        
    }
}

struct HomeTableView: View {
    let homeViewModel: HomeViewModel
    
    @State var index = 0
    @State var offset: CGFloat = 0
    var width = UIScreen.main.bounds.width
    @State var offsetMoved: CGFloat = 0
    
    var body: some View {
        VStack {
            
            VStack(alignment: .center, spacing: 14) {
                Image(homeViewModel.picture, defaultSystemImage: Constants.avatarDefImgName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(.blue, lineWidth: Constants.avatarDefImgBorW)
                    )
                
                Text(homeViewModel.account)
                    .font(.title2.bold())
                Text(homeViewModel.price)
                    .font(.callout)
                    .foregroundColor(Color(UIColor.gray))
                Text(homeViewModel.description)
                    .font(.footnote)
                
                
                
                HStack {
                    TBButton(title: Constants.btnReceptTittle, image: Constants.btnReceptImgName)
                    TBButton(title: Constants.btnBuyTittle, image: Constants.btnBuyImgName)
                    TBButton(title: Constants.btnSendTittle, image: Constants.btnSendImgName)
                    TBButton(title: Constants.btnExchangeTittle, image: Constants.btnExchangeImgName)
                }
                
                AppBar(index: $index, offset: $offset)
                
                GeometryReader{g in
                    HStack {
                        MoneyView()
                            .frame(width: g.frame(in : .global).width, height: 200)
                        CollectView()
                            .frame(width: g.frame(in : .global).width,  height: 200)
                    }
                    .offset(x: self.offset + self.offsetMoved)
                    
                    .highPriorityGesture(DragGesture()
                        .onEnded({ value in
                            if value.translation.width > 150 { // minimum drag...
                                print("right")
                                self.changeView(left: false)
                            } else if value.translation.width < -150 {
                                print("left")
                                self.changeView(left: true)
                            }
                            self.offsetMoved = 0 // 重置微调
                        })
                            .onChanged({ value in
                                self.offsetMoved = value.translation.width // 微调
                            }))
                }
                
                
                
            }
            .padding(.top)
            
        }
    }
    
    
    @ViewBuilder
    func TBButton(title: String, image: String) -> some View {
        VStack {
            Button(action: {}) {
                Image(systemName: image)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                
            }
            .background(Color.blue)
            .cornerRadius(40)
            
            Text(title)
                .font(Font.system(size: 13))
                .foregroundColor(.blue)
        }
    }
    
    
    func changeView(left: Bool) {
        // tab
        if left {
            
            if self.index != 2 {
                self.index += 1
            }
        } else {
            if self.index != 0 {
                self.index -= 1
            }
        }
        
        // view
        if self.index == 0 {
            self.offset = 0
        }
        else if self.index == 1 {
            self.offset = -self.width
        }
        else {
            self.offset = -self.width*2
        }
        // change the width based on the size of the tabs...
    }
}

extension Image {
    init(_ name: String, defaultImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(defaultImage)
        }
    }
    
    init(_ name: String, defaultSystemImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(systemName: defaultSystemImage)
        }
    }
    
}

struct AppBar: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack(alignment: .leading, content: {
            
            HStack {
                
                Button(action: {
                    self.index = 0
                    self.offset = 0
                }) {
                    BtnSegment(title: Constants.segmMoneyTittle, isSelect: self.index==0)
                }
                
                Button(action: {
                    self.index = 1
                    self.offset = -self.width
                }) {
                    BtnSegment(title: Constants.segmCollectTittle, isSelect: self.index==1)
                }
            }
        })
    }
    
    @ViewBuilder
    func BtnSegment(title: String, isSelect: Bool) -> some View {
        VStack {
            Text(title)
                .foregroundColor(isSelect ? .blue : Color.black)
            
            Capsule()
                .foregroundColor(isSelect ? Color.blue : Color.clear)
                .frame(height: 2)
            Spacer().frame(maxWidth: .infinity, maxHeight: 0)
        }
    }
}

struct CollectView: View {
    var body: some View {
        GeometryReader{_ in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    
                    Text(Constants.segmVCollectTittle)
                        .font(.title2.bold())
                    
                }
            }.padding(.bottom, 18)
        }
    }
}

struct MoneyView: View {
    var body: some View {
        
        GeometryReader{_ in
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    HStack(spacing: 15) {
                        Image(Constants.moneyVImgName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                        
                        VStack {
                            Text("0 ETH")
                                .font(.subheadline.bold())
                            Text("$0")
                                .font(.callout)
                                .foregroundColor(Color(UIColor.gray))
                            
                        }.padding(.leading)
                        
                        Spacer()
                        Image(systemName: Constants.moneyVArrImgName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(UIColor.gray))
                            .padding(.trailing, 15)
                    }.padding(.bottom, 15)
                    
                    Divider()
                    
                }
            }.padding(.bottom, 18)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
