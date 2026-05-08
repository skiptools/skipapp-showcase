// Copyright 2023–2025 Skip
import SwiftUI
import SkipGMaps
#if !SKIP
import MapKit
#else
// add dependency in skip.yml: implementation("com.google.maps.android:maps-compose:6.4.1")
import com.google.maps.android.compose.__
import com.google.android.gms.maps.model.CameraPosition
import com.google.android.gms.maps.model.LatLng
#endif

enum MapPlaygroundType: String, CaseIterable {
    case platform
    case google

    var title: String {
        switch self {
        case .platform:
            return "Platform Map"
        case .google:
            return "Google Maps"
        }
    }
}

struct MapPlayground: View {

    var body: some View {
        List(MapPlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .toolbar {
            PlaygroundSourceLink(file: "MapPlayground.swift")
        }
        .navigationDestination(for: MapPlaygroundType.self) {
            switch $0 {
            case .platform:
                PlatformMapPlayground()
                    .navigationTitle($0.title)
            case .google:
                GMapsPlayground()
                    .navigationTitle($0.title)
            }
        }
    }
}

struct GMapsPlayground: View {
    init() {
        GoogleMapsConfiguration.provideAPIKey("AIzaSyBdt_bhz4zi6WAUelkVkEnxMs9pkbEKXKM")
    }

    var body: some View {
        GoogleMapView()
    }
}


struct PlatformMapPlayground: View {
    var body: some View {
        SimpleMapView(latitude: 48.8566, longitude: 2.3522)
    }
}

struct SimpleMapView : View {
    let latitude: Double
    let longitude: Double

    var body: some View {
        #if !SKIP
        // on Darwin platforms, we use the new SwiftUI Map type
        if #available(iOS 17.0, macOS 14.0, *) {
            Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))
        } else {
            Text("Map requires iOS 17")
                .font(.title)
        }
        #else
        // on Android platforms, we use com.google.maps.android.compose.GoogleMap within in a ComposeView
        ComposeView { ctx in
            GoogleMap(cameraPositionState: rememberCameraPositionState {
                position = CameraPosition.fromLatLngZoom(LatLng(latitude, longitude), Float(12.0))
            })
        }
        #endif
    }
}
