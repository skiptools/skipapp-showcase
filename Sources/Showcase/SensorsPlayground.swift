// Copyright 2023–2026 Skip
import SwiftUI
import SkipDevice
import SkipKit

struct SensorsPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AccelerometerCard()
                GyroscopeCard()
                MagnetometerCard()
                BarometerCard()
                LocationCard()
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "SensorsPlayground.swift")
        }
    }
}

// MARK: - Accelerometer

struct AccelerometerCard: View {
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    @State var z: Double = 0.0
    @State var isMonitoring = false
    @State var isAvailable = true
    @State var errorMessage: String?

    var body: some View {
        SensorCard(
            title: "Accelerometer",
            systemImage: "move.3d",
            isAvailable: isAvailable,
            isMonitoring: isMonitoring,
            errorMessage: errorMessage,
            onToggle: { isMonitoring.toggle() }
        ) {
            VStack(spacing: 16) {
                // Spirit level visualization
                spiritLevel
                // Axis bars
                SensorAxisBar(label: "X", value: x, maxValue: 2.0, color: .red)
                SensorAxisBar(label: "Y", value: y, maxValue: 2.0, color: .green)
                SensorAxisBar(label: "Z", value: z, maxValue: 2.0, color: .blue)
            }
        }
        .task(id: isMonitoring) {
            guard isMonitoring else { return }
            let provider = AccelerometerProvider()
            isAvailable = provider.isAvailable
            guard isAvailable else { return }
            provider.updateInterval = 0.05
            do {
                for try await event in provider.monitor() {
                    x = event.x
                    y = event.y
                    z = event.z
                }
            } catch {
                errorMessage = "\(error)"
            }
            provider.stop()
        }
    }

    private var spiritLevel: some View {
        let radius: CGFloat = 60.0
        let clampedX = min(max(x, -1.0), 1.0)
        let clampedY = min(max(y, -1.0), 1.0)
        let dotX = clampedX * radius
        let dotY = -clampedY * radius

        return ZStack {
            // Outer ring
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: radius * 2, height: radius * 2)
            // Crosshairs
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(width: 1, height: radius * 2)
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(width: radius * 2, height: 1)
            // Center reference
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                .frame(width: 8, height: 8)
            // Tilt indicator ball
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.blue.opacity(0.9), Color.blue.opacity(0.5)],
                        center: .center,
                        startRadius: 0,
                        endRadius: 12
                    )
                )
                .frame(width: 24, height: 24)
                .shadow(color: Color.blue.opacity(0.4), radius: 4)
                .offset(x: dotX, y: dotY)
        }
        .frame(width: radius * 2 + 30, height: radius * 2 + 30)
    }
}

// MARK: - Gyroscope

struct GyroscopeCard: View {
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    @State var z: Double = 0.0
    @State var cumulativeAngle: Double = 0.0
    @State var isMonitoring = false
    @State var isAvailable = true
    @State var errorMessage: String?

    var body: some View {
        SensorCard(
            title: "Gyroscope",
            systemImage: "gyroscope",
            isAvailable: isAvailable,
            isMonitoring: isMonitoring,
            errorMessage: errorMessage,
            onToggle: { isMonitoring.toggle() }
        ) {
            VStack(spacing: 16) {
                // Rotation wheel
                rotationWheel
                // Axis bars
                SensorAxisBar(label: "X", value: x, maxValue: 5.0, color: .red)
                SensorAxisBar(label: "Y", value: y, maxValue: 5.0, color: .green)
                SensorAxisBar(label: "Z", value: z, maxValue: 5.0, color: .blue)
                Text("rad/s")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .task(id: isMonitoring) {
            guard isMonitoring else {
                cumulativeAngle = 0
                return
            }
            let provider = GyroscopeProvider()
            isAvailable = provider.isAvailable
            guard isAvailable else { return }
            provider.updateInterval = 0.05
            do {
                for try await event in provider.monitor() {
                    x = event.x
                    y = event.y
                    z = event.z
                    // Integrate z-axis rotation for visual wheel
                    cumulativeAngle += event.z * 0.05 * 180.0 / Double.pi
                }
            } catch {
                errorMessage = "\(error)"
            }
            provider.stop()
        }
    }

    private var rotationWheel: some View {
        let size: CGFloat = 120.0
        return ZStack {
            // Outer ring
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 3)
                .frame(width: size, height: size)
            // Tick marks around the ring
            ForEach(0..<12, id: \.self) { i in
                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 2, height: i % 3 == 0 ? 12.0 : 6.0)
                    .offset(y: -size / 2.0 + 6)
                    .rotationEffect(.degrees(Double(i) * 30.0))
            }
            // Spinning indicator line
            Rectangle()
                .fill(Color.orange)
                .frame(width: 3, height: size / 2.0 - 8)
                .offset(y: -(size / 4.0 - 4))
                .rotationEffect(.degrees(cumulativeAngle))
            // Center dot
            Circle()
                .fill(Color.orange)
                .frame(width: 10, height: 10)
        }
        .frame(width: size + 20, height: size + 20)
    }
}

// MARK: - Magnetometer

struct MagnetometerCard: View {
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    @State var z: Double = 0.0
    @State var isMonitoring = false
    @State var isAvailable = true
    @State var errorMessage: String?

    var heading: Double {
        let angle = atan2(y, x) * 180.0 / Double.pi
        return angle < 0.0 ? angle + 360.0 : angle
    }

    var fieldStrength: Double {
        return sqrt(x * x + y * y + z * z)
    }

    var body: some View {
        SensorCard(
            title: "Magnetometer",
            systemImage: "location.north.fill",
            isAvailable: isAvailable,
            isMonitoring: isMonitoring,
            errorMessage: errorMessage,
            onToggle: { isMonitoring.toggle() }
        ) {
            VStack(spacing: 16) {
                // Compass visualization
                compass
                // Field strength
                HStack {
                    Text("Field Strength:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(String(format: "%.1f \u{00B5}T", fieldStrength))
                        .font(.caption)
                        .fontWeight(.semibold)

                }
                // Axis values
                SensorAxisBar(label: "X", value: x, maxValue: 100.0, color: .red)
                SensorAxisBar(label: "Y", value: y, maxValue: 100.0, color: .green)
                SensorAxisBar(label: "Z", value: z, maxValue: 100.0, color: .blue)
                Text("\u{00B5}T (microteslas)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .task(id: isMonitoring) {
            guard isMonitoring else { return }
            let provider = MagnetometerProvider()
            isAvailable = provider.isAvailable
            guard isAvailable else { return }
            provider.updateInterval = 0.1
            do {
                for try await event in provider.monitor() {
                    x = event.x
                    y = event.y
                    z = event.z
                }
            } catch {
                errorMessage = "\(error)"
            }
            provider.stop()
        }
    }

    private var compass: some View {
        let size: CGFloat = 140.0
        let needleRotation = -heading

        return ZStack {
            // Compass ring
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                .frame(width: size, height: size)
            // Cardinal directions
            ForEach(Array(["N", "E", "S", "W"].enumerated()), id: \.offset) { index, label in
                Text(label)
                    .font(.caption)
                    .fontWeight(label == "N" ? .bold : .regular)
                    .foregroundStyle(label == "N" ? Color.red : Color.secondary)
                    .offset(y: -size / 2.0 - 12)
                    .rotationEffect(.degrees(Double(index) * 90.0))
            }
            // Degree ticks
            ForEach(0..<36, id: \.self) { i in
                Rectangle()
                    .fill(Color.gray.opacity(i % 9 == 0 ? 0.5 : 0.2))
                    .frame(width: 1, height: i % 9 == 0 ? 10.0 : 5.0)
                    .offset(y: -size / 2.0 + 5)
                    .rotationEffect(.degrees(Double(i) * 10.0))
            }
            // Needle
            VStack(spacing: 0) {
                Triangle()
                    .fill(Color.red)
                    .frame(width: 12, height: size / 2.0 - 20)
                Triangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 12, height: size / 2.0 - 20)
                    .rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(needleRotation))
            // Center pin
            Circle()
                .fill(Color.primary)
                .frame(width: 8, height: 8)
            // Heading text
            Text(String(format: "%.0f\u{00B0}", heading))
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(.systemBackground).opacity(0.8))
                )
                .offset(y: size / 2.0 + 16)
        }
        .frame(width: size + 30, height: size + 50)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Barometer

struct BarometerCard: View {
    @State var pressure: Double = 0.0
    @State var relativeAltitude: Double = 0.0
    @State var isMonitoring = false
    @State var isAvailable = true
    @State var errorMessage: String?

    var body: some View {
        SensorCard(
            title: "Barometer",
            systemImage: "barometer",
            isAvailable: isAvailable,
            isMonitoring: isMonitoring,
            errorMessage: errorMessage,
            onToggle: { isMonitoring.toggle() }
        ) {
            VStack(spacing: 16) {
                // Pressure gauge
                pressureGauge
                // Altitude
                HStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Text("Pressure")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Text(String(format: "%.2f kPa", pressure))
                            .font(.title3)
                            .fontWeight(.semibold)
    
                    }
                    VStack(spacing: 4) {
                        Text("Rel. Altitude")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Text(String(format: "%+.2f m", relativeAltitude))
                            .font(.title3)
                            .fontWeight(.semibold)
    
                            .foregroundStyle(relativeAltitude >= 0.0 ? Color.green : Color.orange)
                    }
                }
            }
        }
        .task(id: isMonitoring) {
            guard isMonitoring else { return }
            let provider = BarometerProvider()
            isAvailable = provider.isAvailable
            guard isAvailable else { return }
            provider.updateInterval = 0.5
            do {
                for try await event in provider.monitor() {
                    pressure = event.pressure
                    relativeAltitude = event.relativeAltitude
                }
            } catch {
                errorMessage = "\(error)"
            }
            provider.stop()
        }
    }

    private var pressureGauge: some View {
        // Standard atmospheric pressure is ~101.325 kPa
        // Typical range: 87-108 kPa
        let minP: Double = 87.0
        let maxP: Double = 108.0
        let fraction = pressure > 0.0 ? (pressure - minP) / (maxP - minP) : 0.5
        let clampedFraction = min(max(fraction, 0.0), 1.0)
        let angle = -135.0 + clampedFraction * 270.0

        return ZStack {
            // Background arc
            Circle()
                .trim(from: 0.125, to: 0.875)
                .stroke(Color.gray.opacity(0.15), lineWidth: 12)
                .frame(width: 120, height: 120)
                .rotationEffect(.degrees(90))
            // Colored arc showing current level
            Circle()
                .trim(from: 0.125, to: 0.125 + clampedFraction * 0.75)
                .stroke(
                    LinearGradient(
                        colors: [Color.blue, Color.cyan, Color.green],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .frame(width: 120, height: 120)
                .rotationEffect(.degrees(90))
            // Needle
            Rectangle()
                .fill(Color.primary)
                .frame(width: 2, height: 45)
                .offset(y: -22.5)
                .rotationEffect(.degrees(angle))
            Circle()
                .fill(Color.primary)
                .frame(width: 8, height: 8)
        }
        .frame(width: 150, height: 100)
    }
}

// MARK: - Location

struct LocationCard: View {
    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0
    @State var altitude: Double = 0.0
    @State var speed: Double = 0.0
    @State var course: Double = 0.0
    @State var horizontalAccuracy: Double = 0.0
    @State var isMonitoring = false
    @State var isAvailable = true
    @State var permissionStatus: String = "unknown"
    @State var errorMessage: String?

    var body: some View {
        SensorCard(
            title: "Location",
            systemImage: "location.fill",
            isAvailable: isAvailable,
            isMonitoring: isMonitoring,
            errorMessage: errorMessage,
            onToggle: {
                if !isMonitoring {
                    Task {
                        let status = await PermissionManager.requestLocationPermission(precise: true, always: false)
                        permissionStatus = status.rawValue
                        if status.isAuthorized == true {
                            isMonitoring = true
                        } else {
                            errorMessage = "Location permission \(status.rawValue)"
                        }
                    }
                } else {
                    isMonitoring = false
                }
            }
        ) {
            VStack(spacing: 12) {
                // Permission status
                HStack {
                    Text("Permission:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(permissionStatus)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(permissionStatus == "authorized" ? Color.green : Color.orange)
                }

                if isMonitoring {
                    // Coordinates
                    VStack(spacing: 8) {
                        LocationRow(label: "Latitude", value: String(format: "%.6f\u{00B0}", latitude))
                        LocationRow(label: "Longitude", value: String(format: "%.6f\u{00B0}", longitude))
                        LocationRow(label: "Altitude", value: String(format: "%.1f m", altitude))
                        LocationRow(label: "Speed", value: String(format: "%.1f m/s", max(speed, 0.0)))
                        LocationRow(label: "Course", value: String(format: "%.0f\u{00B0}", course))
                        LocationRow(label: "Accuracy", value: String(format: "\u{00B1}%.1f m", horizontalAccuracy))
                    }

                    // Accuracy indicator
                    accuracyIndicator
                }
            }
        }
        .task {
            permissionStatus = PermissionManager.queryLocationPermission(precise: true, always: false).rawValue
        }
        .task(id: isMonitoring) {
            guard isMonitoring else { return }
            let provider = LocationProvider()
            isAvailable = provider.isAvailable
            guard isAvailable else { return }
            do {
                for try await event in provider.monitor() {
                    latitude = event.latitude
                    longitude = event.longitude
                    altitude = event.altitude
                    speed = event.speed
                    course = event.course
                    horizontalAccuracy = event.horizontalAccuracy
                }
            } catch {
                errorMessage = "\(error)"
            }
            provider.stop()
        }
    }

    private var accuracyIndicator: some View {
        let maxRadius: CGFloat = 50.0
        let accuracyRadius = min(CGFloat(horizontalAccuracy) / 100.0 * maxRadius, maxRadius)

        return ZStack {
            // Accuracy circle
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: maxRadius * 2, height: maxRadius * 2)
            Circle()
                .fill(Color.blue.opacity(0.15))
                .frame(width: accuracyRadius * 2, height: accuracyRadius * 2)
            Circle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                .frame(width: accuracyRadius * 2, height: accuracyRadius * 2)
            // Center dot (you)
            Circle()
                .fill(Color.blue)
                .frame(width: 10, height: 10)
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 10, height: 10)
        }
        .frame(width: maxRadius * 2 + 10, height: maxRadius * 2 + 10)
    }
}

struct LocationRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 80, alignment: .trailing)
            Text(value)
                .font(.callout)
                .fontWeight(.medium)
            Spacer()
        }
    }
}

// MARK: - Shared Components

struct SensorCard<Content: View>: View {
    let title: String
    let systemImage: String
    let isAvailable: Bool
    let isMonitoring: Bool
    let errorMessage: String?
    let onToggle: () -> Void
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Image(systemImage, bundle: .module)
                    .font(.title3)
                    .foregroundStyle(isMonitoring ? Color.accentColor : Color.secondary)
                Text(title)
                    .font(.headline)
                Spacer()
                if !isAvailable {
                    Text("Unavailable")
                        .font(.caption)
                        .foregroundStyle(.red)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.red.opacity(0.1))
                        )
                } else {
                    Button(action: onToggle) {
                        Text(isMonitoring ? "Stop" : "Start")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(isMonitoring ? Color.red : Color.accentColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isMonitoring ? Color.red.opacity(0.1) : Color.accentColor.opacity(0.1))
                            )
                    }
                }
            }

            if isAvailable {
                if isMonitoring {
                    content()
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Tap Start to begin monitoring")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
        )
    }
}

struct SensorAxisBar: View {
    let label: String
    let value: Double
    let maxValue: Double
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(color)
                .frame(width: 16)
            GeometryReader { geo in
                let barWidth = geo.size.width
                let center = barWidth / 2.0
                let fraction = min(max(value / maxValue, -1.0), 1.0)
                let barLen = abs(fraction) * center
                let barStart = fraction >= 0.0 ? center : center - barLen

                ZStack(alignment: .leading) {
                    // Track
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 8)
                    // Center line
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 1, height: 12)
                        .offset(x: center)
                    // Value bar
                    RoundedRectangle(cornerRadius: 3)
                        .fill(color.opacity(0.7))
                        .frame(width: max(barLen, 2), height: 8)
                        .offset(x: barStart)
                }
            }
            .frame(height: 12)
            Text(String(format: "%+.2f", value))
                .font(.caption2)
                .foregroundStyle(.secondary)
                .frame(width: 52, alignment: .trailing)
        }
    }
}
