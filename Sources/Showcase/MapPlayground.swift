// Copyright 2023–2025 Skip
import SwiftUI
#if !SKIP
import MapKit
#else
// add dependency in skip.yml: implementation("com.google.maps.android:maps-compose:6.4.1")
import com.google.maps.android.compose.__
import com.google.android.gms.maps.model.CameraPosition
import com.google.android.gms.maps.model.LatLng
#endif

struct MapPlayground: View {
    var body: some View {
        MapView(latitude: 48.8566, longitude: 2.3522)
    }
}

struct MapView : View {
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
