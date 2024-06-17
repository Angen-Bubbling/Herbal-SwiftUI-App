//
//  LoggedInView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import SwiftUI
import MapKit

struct LoggedInView: View {
    @EnvironmentObject var users: UserViewModel
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    let user: User
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    HeaderLoggedInView(user: user)
                        .padding(.bottom)
                    Divider()
                    ProfilButtons().environmentObject(users)
                    Spacer()
                }
                .navigationBarBackButtonHidden(false)
                .navigationBarTitleDisplayMode(.inline)
            }.navigationBarHidden(true)
        }
    }
}

struct HeaderLoggedInView: View {
    @StateObject var imageLoader = ImageLoader()
    let user: User
    var body: some View {
        HStack {
            ZStack{
                Circle().fill(Color.secondaryBackground)
                    .frame(width: 90, height: 90)
                if let image = imageLoader.image{
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(8)
                }
            }
            .padding()
            VStack(alignment: .leading) {
                Text(user.name ?? "name")
                    .font(.title2)
                    .bold()
                Text(user.email ?? "email")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }.padding()
        .onAppear{
//            imageLoader.loadImage(with: URL(string:user.picture.large)!)
        }
    }
}
