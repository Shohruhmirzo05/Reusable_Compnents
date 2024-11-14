//
//  MapLocationView.swift
//  InoMarket
//
//  Created by Shohruhmirzo Alijonov on 10/10/24.
//

import SwiftUI
import MapKit

struct MapLocationView: View {
    let location: Coordinate
    let imageUrl: String?
    let clLocation: CLLocationCoordinate2D
    let region: MKCoordinateRegion
    let size: CGSize
    
    @State private var mapImage: UIImage?
    @Environment(\.colorScheme) var colorScheme
    
    init(location: Coordinate, imageUrl: String? = nil, size: CGSize) {
        self.location = location
        self.imageUrl = imageUrl
        self.size = size
        clLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        region = MKCoordinateRegion(center: clLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    var body: some View {
        ZStack {
            if let mapImage = mapImage {
                Image(uiImage: mapImage)
                    .resizable()
                    .scaledToFill()
                    .onChange(of: colorScheme) { newScheme in
                        self.mapImage = nil
                    }
            } else {
                Map(coordinateRegion: .constant(region))
                    .allowsHitTesting(false)
                    .onAppear {
                        takeSnapshot()
                    }
            }
            AnnotationItemView(40)
        }
    }
    
    func takeSnapshot() {
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = size
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if let snapshot = snapshot {
                self.mapImage = snapshot.image
            }
        }
    }
    
    @ViewBuilder func AnnotationItemView(_ size: CGFloat) -> some View {
        MapPinShape()
            .fill(Color.accentColor.gradient)
            .aspectRatio(3/4, contentMode: .fit)
            .overlay(alignment: .top) {
                if let imageUrl {
                    ZStack {
                        CachedImage(imageUrl: imageUrl)
                            .aspectRatio(1, contentMode: .fit)
                        Circle()
                            .stroke(Color.white.gradient)
                            .padding(0.5)
                    }
                    .clipShape(Circle())
                    .padding(3)
                }
            }
            .frame(height: size)
            .offset(y: size / -2)
    }
}

#Preview {
    GeometryReader { geometry in
        MapLocationView(location: Coordinate(latitude: 41.2995, longitude: 69.2401), imageUrl: "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg", size: geometry.size)
    }
    .frame(height: 200)
}

struct MapPinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.56172*width, y: 0.975*height))
        path.addCurve(to: CGPoint(x: width, y: 0.375*height), control1: CGPoint(x: 0.69531*width, y: 0.84961*height), control2: CGPoint(x: width, y: 0.5457*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0), control1: CGPoint(x: width, y: 0.16797*height), control2: CGPoint(x: 0.77604*width, y: 0))
        path.addCurve(to: CGPoint(x: 0, y: 0.375*height), control1: CGPoint(x: 0.22396*width, y: 0), control2: CGPoint(x: 0, y: 0.16797*height))
        path.addCurve(to: CGPoint(x: 0.43828*width, y: 0.975*height), control1: CGPoint(x: 0, y: 0.5457*height), control2: CGPoint(x: 0.30469*width, y: 0.84961*height))
        path.addCurve(to: CGPoint(x: 0.56172*width, y: 0.975*height), control1: CGPoint(x: 0.47031*width, y: 1.00488*height), control2: CGPoint(x: 0.52969*width, y: 1.00488*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5*width, y: 0.25*height))
        path.addCurve(to: CGPoint(x: 0.61785*width, y: 0.28661*height), control1: CGPoint(x: 0.5442*width, y: 0.25*height), control2: CGPoint(x: 0.58659*width, y: 0.26317*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.375*height), control1: CGPoint(x: 0.64911*width, y: 0.31005*height), control2: CGPoint(x: 0.66667*width, y: 0.34185*height))
        path.addCurve(to: CGPoint(x: 0.61785*width, y: 0.46339*height), control1: CGPoint(x: 0.66667*width, y: 0.40815*height), control2: CGPoint(x: 0.64911*width, y: 0.43995*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.5*height), control1: CGPoint(x: 0.58659*width, y: 0.48683*height), control2: CGPoint(x: 0.5442*width, y: 0.5*height))
        path.addCurve(to: CGPoint(x: 0.38215*width, y: 0.46339*height), control1: CGPoint(x: 0.4558*width, y: 0.5*height), control2: CGPoint(x: 0.41341*width, y: 0.48683*height))
        path.addCurve(to: CGPoint(x: 0.33333*width, y: 0.375*height), control1: CGPoint(x: 0.35089*width, y: 0.43995*height), control2: CGPoint(x: 0.33333*width, y: 0.40815*height))
        path.addCurve(to: CGPoint(x: 0.38215*width, y: 0.28661*height), control1: CGPoint(x: 0.33333*width, y: 0.34185*height), control2: CGPoint(x: 0.35089*width, y: 0.31005*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.25*height), control1: CGPoint(x: 0.41341*width, y: 0.26317*height), control2: CGPoint(x: 0.4558*width, y: 0.25*height))
        path.closeSubpath()
        return path
    }
}
