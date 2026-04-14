// Flappy Bird in SwiftUI for iOS and Android!
import SwiftUI
import Observation
import SkipKit

public struct GamePlayground: View {
    @State var settings = FlappyBirdSettings()

    public init() { }

    public var body: some View {
        FlappyBirdGameView()
            .navigationTitle("")
            #if os(iOS) || os(Android)
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            #endif
            .colorScheme(.dark)
            .environment(settings)
    }
}

public func resetFlappyBirdHighScore() {
    UserDefaults.standard.set(0, forKey: "flappybird_highscore")
}

// MARK: - Constants

private let birdSize: Double = 30.0
private let groundHeight: Double = 80.0
private let birdX: Double = 80.0
private let pipeWidth: Double = 52.0

/// Difficulty-dependent parameters. Difficulty ranges from 1 (easiest) to 10 (hardest).
/// Level 5 matches the original game feel.
private func effectiveGravity(_ difficulty: Int) -> Double {
    // 1 → 750, 5 → 950, 10 → 1200
    return 750.0 + Double(difficulty - 1) * 50.0
}

private func effectiveFlapVelocity(_ difficulty: Int) -> Double {
    // 1 → -290, 5 → -330, 10 → -380
    return -290.0 - Double(difficulty - 1) * 10.0
}

private func effectivePipeSpeed(_ difficulty: Int) -> Double {
    // 1 → 90, 5 → 130, 10 → 180
    return 90.0 + Double(difficulty - 1) * 10.0
}

private func effectivePipeGap(_ difficulty: Int) -> Double {
    // 1 → 210, 5 → 160, 10 → 115
    return 210.0 - Double(difficulty - 1) * 10.5
}

private func effectivePipeSpacing(_ difficulty: Int) -> Double {
    // 1 → 280, 5 → 210, 10 → 155
    return 280.0 - Double(difficulty - 1) * 14.0
}

// MARK: - Pipe Model

final class PipeData: Identifiable {
    let id: Int
    var x: Double
    let gapY: Double // center of the gap
    var scored: Bool

    init(id: Int, x: Double, gapY: Double) {
        self.id = id
        self.x = x
        self.gapY = gapY
        self.scored = false
    }
}

// MARK: - Game Model

@Observable
final class FlappyBirdModel {
    var birdY: Double = 0.0
    var birdVelocity: Double = 0.0
    var birdRotation: Double = 0.0
    var wingAngle: Double = 0.0 // -1 = up, 0 = mid, 1 = down
    var wingTimer: Double = 0.0
    var pipes: [PipeData] = []
    var score: Int = 0
    var highScore: Int = UserDefaults.standard.integer(forKey: "flappybird_highscore")
    var isGameOver: Bool = false
    var hasStarted: Bool = false
    var fieldHeight: Double = 600.0
    var fieldWidth: Double = 400.0
    var difficulty: Int = 5

    private var nextPipeID: Int = 0

    private var gravity: Double { effectiveGravity(difficulty) }
    private var flapVel: Double { effectiveFlapVelocity(difficulty) }
    private var speed: Double { effectivePipeSpeed(difficulty) }
    private var gap: Double { effectivePipeGap(difficulty) }
    private var spacing: Double { effectivePipeSpacing(difficulty) }

    func setup(width: Double, height: Double) {
        fieldWidth = width
        fieldHeight = height
    }

    func newGame() {
        birdY = fieldHeight * 0.4
        birdVelocity = 0.0
        birdRotation = 0.0
        wingAngle = 0.0
        wingTimer = 0.0
        pipes = []
        score = 0
        isGameOver = false
        hasStarted = false
        nextPipeID = 0
    }

    func flap() {
        if isGameOver { return }
        if !hasStarted {
            hasStarted = true
            spawnInitialPipes()
        }
        birdVelocity = flapVel
        wingTimer = 0.3 // start a flap cycle lasting 0.3s
        wingAngle = -1.0 // wing up
    }

    func update(dt: Double) {
        guard hasStarted && !isGameOver else { return }

        // Physics
        birdVelocity += gravity * dt
        birdY += birdVelocity * dt

        // Bird rotation: nose up at -25 when flapping, rotate down to +90 when falling
        let clampedVel = min(max(birdVelocity, flapVel), 400.0)
        birdRotation = ((clampedVel - flapVel) / (400.0 - flapVel)) * 115.0 - 25.0

        // Wing animation: flap cycle over 0.3s
        // -1 (up) → 0 (mid) → 1 (down) → 0 (mid, rest)
        if wingTimer > 0.0 {
            wingTimer -= dt
            if wingTimer <= 0.0 {
                wingTimer = 0.0
                wingAngle = 0.0
            } else {
                let t = 1.0 - wingTimer / 0.3 // 0→1 over the cycle
                if t < 0.33 {
                    wingAngle = -1.0 + t * 3.0 // -1 → 0
                } else if t < 0.66 {
                    wingAngle = (t - 0.33) * 3.0 // 0 → 1
                } else {
                    wingAngle = 1.0 - (t - 0.66) * 3.0 // 1 → 0
                }
            }
        }

        // Move pipes
        let dx = speed * dt
        for pipe in pipes {
            pipe.x -= dx
        }

        // Score — bird passes the trailing edge of a pipe
        for pipe in pipes {
            if !pipe.scored && pipe.x + pipeWidth < birdX {
                pipe.scored = true
                score += 1
            }
        }

        // Remove off-screen pipes
        pipes = pipes.filter { $0.x + pipeWidth > -10.0 }

        // Spawn new pipes
        if let last = pipes.last {
            if last.x < fieldWidth - spacing {
                spawnPipe(atX: fieldWidth + 20.0)
            }
        } else {
            spawnPipe(atX: fieldWidth + 20.0)
        }

        // Collision detection
        let playableHeight = fieldHeight - groundHeight
        if birdY - birdSize / 2.0 < 0.0 || birdY + birdSize / 2.0 > playableHeight {
            gameOver()
            return
        }

        for pipe in pipes {
            if birdX + birdSize / 2.0 > pipe.x && birdX - birdSize / 2.0 < pipe.x + pipeWidth {
                let topPipeBottom = pipe.gapY - gap / 2.0
                let bottomPipeTop = pipe.gapY + gap / 2.0
                if birdY - birdSize / 2.0 < topPipeBottom || birdY + birdSize / 2.0 > bottomPipeTop {
                    gameOver()
                    return
                }
            }
        }
    }

    private func spawnInitialPipes() {
        var x = fieldWidth + 60.0
        for _ in 0..<3 {
            spawnPipe(atX: x)
            x += spacing
        }
    }

    private func spawnPipe(atX x: Double) {
        let playable = fieldHeight - groundHeight
        let margin = gap / 2.0 + 40.0
        let maxGap = playable - gap / 2.0 - 40.0
        let gapY = Double.random(in: margin...max(margin, maxGap))
        let pipe = PipeData(id: nextPipeID, x: x, gapY: gapY)
        nextPipeID += 1
        pipes.append(pipe)
    }

    private func gameOver() {
        isGameOver = true
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "flappybird_highscore")
        }
    }
}

// MARK: - Game View

struct FlappyBirdGameView: View {
    @State var game = FlappyBirdModel()
    @State var tickTimer: Timer? = nil
    @State var lastTick: Double = 0.0
    @State var showPauseMenu = false
    @State var showSettings = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    @Environment(FlappyBirdSettings.self) var settings: FlappyBirdSettings

    func playHaptic(_ pattern: HapticPattern) {
        if settings.vibrations {
            HapticFeedback.play(pattern)
        }
    }

    var body: some View {
        GeometryReader { geo in
            let _ = initField(geo: geo)
            ZStack {
                // Sky background
                LinearGradient(
                    colors: [
                        Color(red: 0.30, green: 0.75, blue: 0.93),
                        Color(red: 0.55, green: 0.85, blue: 0.95)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Game field
                gameField(width: geo.size.width, height: geo.size.height)

                // HUD overlay
                headerView
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, 8)

                // Tap to start
                if !game.hasStarted && !game.isGameOver {
                    startPrompt
                }

                // Game over
                if game.isGameOver {
                    gameOverOverlay
                }

                if showPauseMenu && !game.isGameOver {
                    pauseMenuOverlay
                }
            }
            .onTapGesture {
                if game.isGameOver || showPauseMenu { return }
                game.flap()
                playHaptic(.pick)
            }
        }
        .navigationBarBackButtonHidden()
        #if !os(macOS)
        .toolbar(.hidden, for: .navigationBar)
        #endif
        .onAppear {
            game.difficulty = settings.difficulty
            game.newGame()
            startTimer()
        }
        .onDisappear { stopTimer() }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase != .active {
                pauseGame()
            }
        }
        .sheet(isPresented: $showSettings) {
            FlappyBirdSettingsView(settings: settings)
        }
        .onChange(of: settings.difficulty) { _, newVal in
            game.difficulty = newVal
        }
    }

    private func initField(geo: GeometryProxy) -> Bool {
        game.setup(width: geo.size.width, height: geo.size.height)
        return true
    }

    // MARK: - Game Field

    func gameField(width: Double, height: Double) -> some View {
        let playableHeight = height - groundHeight

        return ZStack(alignment: .topLeading) {
            // Pipes
            ForEach(game.pipes) { pipe in
                pipeView(pipe: pipe, playableHeight: playableHeight)
            }

            // Bird
            birdView
                .position(x: birdX, y: game.birdY)

            // Ground
            groundView(width: width, height: height)
        }
    }

    // MARK: - Bird
    //
    // Chunky, slightly wider-than-tall yellow bird viewed from the side.
    // Body is an egg-shaped ellipse with a dark outline. A small wing
    // protrudes from the back of the body and flaps when the player taps.
    // wingAngle drives the wing position: -1 = raised, 0 = mid, 1 = lowered.

    var birdView: some View {
        let s = birdSize
        let w = s * 1.18 // slightly wider than tall, egg-shaped
        // Wing vertical offset driven by wingAngle (-1 up, 0 mid, 1 down)
        let wingY = game.wingAngle * s * 0.22

        return ZStack {
            // Dark outline — slightly larger ellipse behind the body
            Ellipse()
                .fill(Color(red: 0.20, green: 0.15, blue: 0.05))
                .frame(width: w + 4, height: s + 4)

            // Main body — warm yellow, egg-shaped
            Ellipse()
                .fill(Color(red: 0.98, green: 0.82, blue: 0.15))
                .frame(width: w, height: s)

            // Belly highlight — lighter yellow on the lower half
            Ellipse()
                .fill(Color(red: 1.0, green: 0.93, blue: 0.50))
                .frame(width: w * 0.50, height: s * 0.30)
                .offset(y: s * 0.18)

            // Wing — small rounded shape that moves up/down with the flap
            // Wing outline
            Ellipse()
                .fill(Color(red: 0.20, green: 0.15, blue: 0.05))
                .frame(width: s * 0.42, height: s * 0.28)
                .offset(x: -w * 0.22, y: s * 0.02 + wingY)
            // Wing fill
            Ellipse()
                .fill(Color(red: 0.90, green: 0.72, blue: 0.12))
                .frame(width: s * 0.38, height: s * 0.24)
                .offset(x: -w * 0.22, y: s * 0.02 + wingY)
            // Wing inner highlight
            Ellipse()
                .fill(Color(red: 1.0, green: 0.88, blue: 0.35))
                .frame(width: s * 0.22, height: s * 0.13)
                .offset(x: -w * 0.22, y: s * 0.00 + wingY)

            // Tail feathers — tiny dark mark at the back
            Ellipse()
                .fill(Color(red: 0.20, green: 0.15, blue: 0.05))
                .frame(width: s * 0.14, height: s * 0.22)
                .offset(x: -w * 0.52, y: -s * 0.02)
            Ellipse()
                .fill(Color(red: 0.75, green: 0.58, blue: 0.08))
                .frame(width: s * 0.10, height: s * 0.18)
                .offset(x: -w * 0.52, y: -s * 0.02)

            // Eye — large white circle with black pupil, positioned upper-front
            // Eye outline
            Circle()
                .fill(Color(red: 0.20, green: 0.15, blue: 0.05))
                .frame(width: s * 0.40, height: s * 0.40)
                .offset(x: w * 0.16, y: -s * 0.14)
            Circle()
                .fill(Color.white)
                .frame(width: s * 0.36, height: s * 0.36)
                .offset(x: w * 0.16, y: -s * 0.14)
            // Pupil — pushed toward the front
            Circle()
                .fill(Color.black)
                .frame(width: s * 0.17, height: s * 0.17)
                .offset(x: w * 0.24, y: -s * 0.13)

            // Beak — two-part, protruding from the front
            // Upper beak (orange-yellow)
            Ellipse()
                .fill(Color(red: 0.20, green: 0.15, blue: 0.05))
                .frame(width: s * 0.38, height: s * 0.20)
                .offset(x: w * 0.44, y: s * 0.04)
            Ellipse()
                .fill(Color(red: 0.96, green: 0.58, blue: 0.12))
                .frame(width: s * 0.34, height: s * 0.16)
                .offset(x: w * 0.44, y: s * 0.04)

            // Lower beak (darker red-orange)
            Ellipse()
                .fill(Color(red: 0.20, green: 0.15, blue: 0.05))
                .frame(width: s * 0.34, height: s * 0.16)
                .offset(x: w * 0.42, y: s * 0.15)
            Ellipse()
                .fill(Color(red: 0.88, green: 0.30, blue: 0.12))
                .frame(width: s * 0.30, height: s * 0.12)
                .offset(x: w * 0.42, y: s * 0.15)
        }
        .rotationEffect(.degrees(min(max(game.birdRotation, -25.0), 90.0)))
    }

    // MARK: - Pipes

    func pipeView(pipe: PipeData, playableHeight: Double) -> some View {
        let currentGap = effectivePipeGap(game.difficulty)
        let topHeight = pipe.gapY - currentGap / 2.0
        let bottomY = pipe.gapY + currentGap / 2.0
        let bottomHeight = playableHeight - bottomY

        return ZStack(alignment: .topLeading) {
            // Top pipe
            if topHeight > 0.0 {
                pipeRect(width: pipeWidth, height: topHeight)
                    .position(x: pipe.x + pipeWidth / 2.0, y: topHeight / 2.0)

                // Top pipe cap (lip at the opening)
                pipeCap(width: pipeWidth + 8.0)
                    .position(x: pipe.x + pipeWidth / 2.0, y: topHeight - 12.0)
            }

            // Bottom pipe
            if bottomHeight > 0.0 {
                pipeRect(width: pipeWidth, height: bottomHeight)
                    .position(x: pipe.x + pipeWidth / 2.0, y: bottomY + bottomHeight / 2.0)

                // Bottom pipe cap
                pipeCap(width: pipeWidth + 8.0)
                    .position(x: pipe.x + pipeWidth / 2.0, y: bottomY + 12.0)
            }
        }
    }

    func pipeRect(width: Double, height: Double) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(red: 0.32, green: 0.68, blue: 0.22))
                .frame(width: width, height: height)
            // Highlight stripe
            RoundedRectangle(cornerRadius: 1)
                .fill(Color(red: 0.42, green: 0.78, blue: 0.30))
                .frame(width: width * 0.3, height: height)
                .offset(x: -width * 0.15)
            // Shadow stripe
            RoundedRectangle(cornerRadius: 1)
                .fill(Color(red: 0.22, green: 0.55, blue: 0.15))
                .frame(width: width * 0.15, height: height)
                .offset(x: width * 0.35)
        }
    }

    func pipeCap(width: Double) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(red: 0.32, green: 0.68, blue: 0.22))
                .frame(width: width, height: 24)
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(red: 0.42, green: 0.78, blue: 0.30))
                .frame(width: width * 0.3, height: 24)
                .offset(x: -width * 0.15)
        }
    }

    // MARK: - Ground

    func groundView(width: Double, height: Double) -> some View {
        VStack(spacing: 0) {
            Spacer()
            // Grass edge
            Rectangle()
                .fill(Color(red: 0.55, green: 0.78, blue: 0.22))
                .frame(height: 8)
            // Dirt
            Rectangle()
                .fill(Color(red: 0.84, green: 0.72, blue: 0.48))
                .frame(height: groundHeight - 8.0)
        }
        .frame(width: width, height: height)
    }

    // MARK: - HUD

    var headerView: some View {
        HStack(spacing: 12) {
            Button(action: { dismiss() }) {
                Image("cancel", bundle: .module)
                    .font(.title2)
                    .foregroundStyle(Color.white.opacity(0.8))
            }
            Spacer()

            // Score display
            VStack(spacing: 0) {
                Text("\(game.score)")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
            }

            Spacer()
            Button(action: { pauseGame() }) {
                Image("pause_circle", bundle: .module)
                    .font(.title2)
                    .foregroundStyle(Color.white.opacity(0.8))
            }
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Start Prompt

    var startPrompt: some View {
        VStack(spacing: 16) {
            Text("TAP TO FLY")
                .font(.title)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)

            // Bouncing arrow hint
            Text("\u{25B2}")
                .font(.largeTitle)
                .foregroundStyle(Color.white.opacity(0.7))
        }
    }

    // MARK: - Game Over

    var gameOverOverlay: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("GAME OVER")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)

                VStack(spacing: 4) {
                    Text("Score")
                        .font(.headline)
                        .foregroundStyle(Color.white.opacity(0.7))
                    Text("\(game.score)")
                        .font(.system(size: 44))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.yellow)
                        .monospaced()
                }

                VStack(spacing: 2) {
                    Text("Best")
                        .font(.caption)
                        .foregroundStyle(Color.white.opacity(0.6))
                    Text("\(game.highScore)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                }

                VStack(spacing: 2) {
                    Text("Difficulty")
                        .font(.caption)
                        .foregroundStyle(Color.white.opacity(0.6))
                    Text("\(game.difficulty)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                }

                if game.score >= game.highScore && game.score > 0 {
                    Text("New High Score!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.yellow)
                }

                Button(action: {
                    game.difficulty = settings.difficulty
                    game.newGame()
                    startTimer()
                    playHaptic(.snap)
                }) {
                    Text("Play Again")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .frame(width: 160)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding(.top, 4)

                Button(action: { dismiss() }) {
                    Text("Quit Game")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .frame(width: 160)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)

                ShareLink(
                    item: "I scored \(game.score) in Flappy Bird (difficulty \(game.difficulty)) on Ship Showcase! Can you beat it?\nhttps://skip.dev/docs/samples/skipapp-showcase-fuse/",
                    subject: Text("Flappy Bird Score"),
                    message: Text("I scored \(game.score) in Flappy Bird!")
                ) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.subheadline)
                        .foregroundStyle(Color.white.opacity(0.7))
                }
            }
            .padding(28)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.1, green: 0.1, blue: 0.2))
            )
        }
    }

    // MARK: - Pause Menu

    var pauseMenuOverlay: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("PAUSED")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)

                Button(action: { resumeGame() }) {
                    Text("Resume")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: 180, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.2, green: 0.6, blue: 0.3))
                        )
                }
                .buttonStyle(.plain)

                Button(action: { showSettings = true }) {
                    Text("Settings")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: 180, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.3, green: 0.4, blue: 0.6))
                        )
                }
                .buttonStyle(.plain)

                Button(action: { dismiss() }) {
                    Text("Quit Game")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: 180, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.8, green: 0.2, blue: 0.2))
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(28)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.1, green: 0.1, blue: 0.2))
            )
        }
    }

    func pauseGame() {
        guard !showPauseMenu else { return }
        stopTimer()
        showPauseMenu = true
    }

    func resumeGame() {
        showPauseMenu = false
        startTimer()
    }

    // MARK: - Timer

    func startTimer() {
        stopTimer()
        lastTick = currentTime()
        tickTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            tick()
        }
    }

    func stopTimer() {
        tickTimer?.invalidate()
        tickTimer = nil
    }

    func tick() {
        let now = currentTime()
        var dt = now - lastTick
        lastTick = now

        // Clamp to avoid huge jumps after backgrounding
        if dt > 0.1 { dt = 0.016 }

        game.update(dt: dt)

        if game.isGameOver {
            playHaptic(.impact)
            stopTimer()
        }
    }

    func currentTime() -> Double {
        return Date().timeIntervalSince1970
    }
}

// MARK: - Preview Icon

public struct FlappyBirdPreviewIcon: View {
    public init() { }

    public var body: some View {
        ZStack {
            // Sky
            LinearGradient(
                colors: [
                    Color(red: 0.30, green: 0.75, blue: 0.93),
                    Color(red: 0.55, green: 0.85, blue: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            // Mini pipes
            HStack(spacing: 20) {
                miniPipe(gapOffset: -10.0)
                miniPipe(gapOffset: 8.0)
            }

            // Mini bird — egg-shaped yellow body, wing, white eye, orange beak
            ZStack {
                // Outline
                Ellipse()
                    .fill(Color(red: 0.20, green: 0.15, blue: 0.05))
                    .frame(width: 18, height: 16)
                // Body
                Ellipse()
                    .fill(Color(red: 0.98, green: 0.82, blue: 0.15))
                    .frame(width: 16, height: 14)
                // Wing
                Ellipse()
                    .fill(Color(red: 0.90, green: 0.72, blue: 0.12))
                    .frame(width: 6, height: 4)
                    .offset(x: -4, y: 1)
                // Eye
                Circle()
                    .fill(Color.white)
                    .frame(width: 5, height: 5)
                    .offset(x: 4, y: -2)
                Circle()
                    .fill(Color.black)
                    .frame(width: 2.5, height: 2.5)
                    .offset(x: 5, y: -1.5)
                // Beak
                Ellipse()
                    .fill(Color(red: 0.96, green: 0.58, blue: 0.12))
                    .frame(width: 6, height: 3)
                    .offset(x: 9, y: 1)
            }
            .offset(x: -8, y: -4)

            // Ground
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color(red: 0.55, green: 0.78, blue: 0.22))
                    .frame(height: 3)
                Rectangle()
                    .fill(Color(red: 0.84, green: 0.72, blue: 0.48))
                    .frame(height: 16)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    func miniPipe(gapOffset: Double) -> some View {
        VStack(spacing: 28) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(red: 0.32, green: 0.68, blue: 0.22))
                .frame(width: 14, height: 30)
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(red: 0.32, green: 0.68, blue: 0.22))
                .frame(width: 14, height: 30)
        }
        .offset(y: gapOffset)
    }
}

// MARK: - Settings

struct FlappyBirdSettingsView: View {
    @Bindable var settings: FlappyBirdSettings
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Flappy Bird") {
                    Toggle("Vibrations", isOn: $settings.vibrations)
                }
                Section("Difficulty") {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Level")
                            Spacer()
                            Text("\(settings.difficulty)")
                                .foregroundStyle(Color.secondary)
                                .monospaced()
                        }
                        Slider(
                            value: Binding(
                                get: { Double(settings.difficulty) },
                                set: { settings.difficulty = Int($0.rounded()) }
                            ),
                            in: 1.0...10.0,
                            step: 1.0
                        )
                        HStack {
                            Text("Easy")
                                .font(.caption2)
                                .foregroundStyle(Color.secondary)
                            Spacer()
                            Text("Hard")
                                .font(.caption2)
                                .foregroundStyle(Color.secondary)
                        }
                    }
                }
                .textCase(nil)
                Section("Data") {
                    Button(role: .destructive, action: {
                        resetFlappyBirdHighScore()
                    }) {
                        Text("Reset High Score")
                    }
                }
            }
            .navigationTitle("Settings")
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

@Observable
public class FlappyBirdSettings {
    public var vibrations: Bool = defaults.value(forKey: "flappyBirdVibrations", default: true) {
        didSet { defaults.set(vibrations, forKey: "flappyBirdVibrations") }
    }

    public var difficulty: Int = defaults.value(forKey: "flappyBirdDifficulty", default: 5) {
        didSet { defaults.set(difficulty, forKey: "flappyBirdDifficulty") }
    }

    public init() {
    }
}

nonisolated(unsafe) private let defaults = UserDefaults.standard

private extension UserDefaults {
    func value<T>(forKey key: String, default defaultValue: T) -> T {
        UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
}
