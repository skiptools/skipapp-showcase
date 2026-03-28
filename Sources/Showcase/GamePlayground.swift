// Copyright 2023–2026 Skip
import SwiftUI
import Observation
import SkipKit

struct GamePlayground: View {
    var body: some View {
        BlockBlastGameView()
            .navigationTitle("")
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
    }
}

/// A mini block blast game
struct BlockBlastGameView: View {
    @State var game = GameModel()
    @State var dragPieceIndex: Int = -1
    @State var dragOffset: CGSize = CGSize.zero
    @State var dragLocation: CGPoint = CGPoint.zero
    @State var isDragging: Bool = false
    @State var highlightRow: Int = -1
    @State var highlightCol: Int = -1
    @State var highlightValid: Bool = false
    @State var boardOrigin: CGPoint = CGPoint.zero
    @State var cellSize: CGFloat = 0
    @State var showCombo: Bool = false
    @State var prevHighlightRow: Int = -1
    @State var prevHighlightCol: Int = -1
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 0.12, green: 0.13, blue: 0.25),
                    Color(red: 0.08, green: 0.08, blue: 0.18)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 12) {
                // Score header
                scoreHeader

                // Game board
                gameBoard

                // Piece tray
                pieceTray

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)

            // Game over overlay
            if game.isGameOver {
                gameOverOverlay
            }

            // Combo popup
            if showCombo && game.lastLinesCleared > 0 {
                comboPopup
            }

        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Score Header

    var scoreHeader: some View {
        HStack(spacing: 12) {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color.white.opacity(0.7))
                    .frame(width: 30, height: 30)
                    .background(Color.white.opacity(0.12))
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("SCORE")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white.opacity(0.6))
                Text("\(game.score)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            }

            Spacer()

            Text("Block Blast")
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundStyle(Color.white)

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("BEST")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white.opacity(0.6))
                Text("\(game.highScore)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.yellow)
            }
        }
        .padding(.leading, 12)
        .padding(.trailing, 16)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
        )
    }

    // MARK: - Game Board

    var gameBoard: some View {
        GeometryReader { geo in
            let boardSize = min(geo.size.width, geo.size.height)
            let cs = boardSize / CGFloat(GameModel.gridSize)
            let originX = (geo.size.width - boardSize) / 2.0
            let originY: CGFloat = 0

            ZStack(alignment: .topLeading) {
                // Board background
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.15, green: 0.16, blue: 0.3))
                    .frame(width: boardSize, height: boardSize)
                    .offset(x: originX)

                // Grid cells
                ForEach(0..<GameModel.gridSize, id: \.self) { row in
                    ForEach(0..<GameModel.gridSize, id: \.self) { col in
                        let cellValue = game.grid[row][col]
                        let isHighlight = isDragging && isHighlightCell(row: row, col: col)

                        cellView(
                            colorIndex: cellValue,
                            isHighlight: isHighlight,
                            isValidHighlight: highlightValid,
                            size: cs
                        )
                        .offset(
                            x: originX + CGFloat(col) * cs,
                            y: originY + CGFloat(row) * cs
                        )
                    }
                }
            }
            .onAppear {
                cellSize = cs
            }
            .onChange(of: geo.size) {
                let newBoardSize = min(geo.size.width, geo.size.height)
                cellSize = newBoardSize / CGFloat(GameModel.gridSize)
            }
            .background(
                // Track the board's global frame so boardOrigin stays
                // correct even after the navigation bar is hidden.
                // Re-read on appear, size change, and drag start to
                // catch position shifts from toolbar visibility changes.
                GeometryReader { boardGeo in
                    Color.clear
                        .onAppear { updateBoardOrigin(boardGeo) }
                        .onChange(of: boardGeo.size) { updateBoardOrigin(boardGeo) }
                        .onChange(of: isDragging) { updateBoardOrigin(boardGeo) }
                }
                .frame(width: boardSize, height: boardSize)
                .offset(x: originX)
            )
        }
        .aspectRatio(1.0, contentMode: .fit)
    }

    func updateBoardOrigin(_ geo: GeometryProxy) {
        let frame = geo.frame(in: .global)
        boardOrigin = CGPoint(x: frame.minX, y: frame.minY)
    }

    func isHighlightCell(row: Int, col: Int) -> Bool {
        if highlightRow < 0 || highlightCol < 0 { return false }
        if dragPieceIndex < 0 || dragPieceIndex >= game.currentPieces.count { return false }
        guard let piece = game.currentPieces[dragPieceIndex] else { return false }
        for cell in piece.shape.cells {
            if row == highlightRow + cell.row && col == highlightCol + cell.col {
                return true
            }
        }
        return false
    }

    func cellView(colorIndex: Int, isHighlight: Bool, isValidHighlight: Bool, size: CGFloat) -> some View {
        let inset: CGFloat = 1.5
        return ZStack {
            if isHighlight {
                RoundedRectangle(cornerRadius: 3)
                    .fill(isValidHighlight ? Color.white.opacity(0.4) : Color.red.opacity(0.3))
                    .frame(width: size - inset * 2, height: size - inset * 2)
            } else if colorIndex >= 0 {
                RoundedRectangle(cornerRadius: 3)
                    .fill(BlockColors.color(for: colorIndex))
                    .frame(width: size - inset * 2, height: size - inset * 2)
                RoundedRectangle(cornerRadius: 3)
                    .fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.3), Color.clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size - inset * 2, height: size - inset * 2)
            } else {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white.opacity(0.05))
                    .frame(width: size - inset * 2, height: size - inset * 2)
            }
        }
        .frame(width: size, height: size)
    }

    // MARK: - Piece Tray

    var pieceTray: some View {
        HStack(spacing: 16) {
            ForEach(0..<3, id: \.self) { index in
                pieceView(index: index)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
        )
    }

    /// Fixed height for each piece slot — accommodates the tallest piece (5 cells)
    var pieceSlotHeight: CGFloat {
        let pieceScale: CGFloat = cellSize > 0.0 ? cellSize * 0.55 : 16.0
        return max(pieceScale * 5.0, 60.0)
    }

    func pieceView(index: Int) -> some View {
        let piece = game.currentPieces[index]
        let pieceScale: CGFloat = cellSize > 0.0 ? cellSize * 0.55 : 16.0
        let isBeingDragged = isDragging && dragPieceIndex == index
        let slotHeight = pieceSlotHeight

        return ZStack {
            if let piece = piece {
                let w = piece.shape.width
                let h = piece.shape.height
                let pieceWidth = CGFloat(w) * pieceScale
                let pieceHeight = CGFloat(h) * pieceScale

                ZStack(alignment: .topLeading) {
                    ForEach(0..<piece.shape.cells.count, id: \.self) { ci in
                        let cell = piece.shape.cells[ci]
                        RoundedRectangle(cornerRadius: 2)
                            .fill(BlockColors.color(for: piece.shape.colorIndex))
                            .frame(width: pieceScale - 2, height: pieceScale - 2)
                            .offset(
                                x: CGFloat(cell.col) * pieceScale + 1,
                                y: CGFloat(cell.row) * pieceScale + 1
                            )
                    }
                }
                .frame(width: pieceWidth, height: pieceHeight, alignment: .topLeading)
                .opacity(isBeingDragged ? 0.3 : 1.0)
            }
            // Invisible hit area that always maintains the fixed slot size
            Color.white.opacity(0.001)
        }
        .frame(maxWidth: .infinity)
        .frame(height: slotHeight)
        .gesture(
            DragGesture(coordinateSpace: .global)
                .onChanged { value in
                    if game.currentPieces[index] != nil {
                        handleDragChanged(index: index, value: value)
                    }
                }
                .onEnded { value in
                    if game.currentPieces[index] != nil {
                        handleDragEnded(index: index, value: value)
                    }
                }
        )
    }

    // MARK: - Drag Handling

    func handleDragChanged(index: Int, value: DragGesture.Value) {
        let wasAlreadyDragging = isDragging
        isDragging = true
        dragPieceIndex = index
        dragOffset = value.translation
        dragLocation = value.location

        if !wasAlreadyDragging {
            HapticFeedback.play(.pick)
        }

        // Calculate which grid cell the drag is over
        guard let piece = game.currentPieces[index] else { return }
        let shape = piece.shape

        // Offset the target point so the shape centers on the finger
        // with a vertical offset so the piece appears above the finger
        let fingerOffset: CGFloat = cellSize * 2.5
        let targetX = dragLocation.x - boardOrigin.x - CGFloat(shape.width) * cellSize / 2.0
        let targetY = dragLocation.y - boardOrigin.y - fingerOffset - CGFloat(shape.height) * cellSize / 2.0

        let col = Int(round(targetX / cellSize))
        let row = Int(round(targetY / cellSize))

        // Fire snap haptic when moving to a new valid grid cell
        if row != prevHighlightRow || col != prevHighlightCol {
            let isValid = game.canPlace(shape: shape, atRow: row, col: col)
            if isValid {
                HapticFeedback.play(.snap)
            }
            prevHighlightRow = row
            prevHighlightCol = col
        }

        highlightRow = row
        highlightCol = col
        highlightValid = game.canPlace(shape: shape, atRow: row, col: col)
    }

    func handleDragEnded(index: Int, value: DragGesture.Value) {
        if highlightValid && highlightRow >= 0 && highlightCol >= 0 {
            if let piece = game.currentPieces[index] {
                game.placeShape(shape: piece.shape, atRow: highlightRow, col: highlightCol, pieceIndex: index)

                if game.comboStreak > 2 {
                    HapticFeedback.play(.combo(streak: game.comboStreak))
                } else if game.lastLinesCleared > 1 {
                    HapticFeedback.play(.bigCelebrate)
                } else if game.lastLinesCleared > 0 {
                    HapticFeedback.play(.celebrate)
                } else {
                    HapticFeedback.play(.place)
                }

                if game.lastLinesCleared > 0 {
                    showCombo = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showCombo = false
                    }
                }

                if game.isGameOver {
                    HapticFeedback.play(.error)
                }
            }
        } else if isDragging {
            HapticFeedback.play(.warning)
        }

        isDragging = false
        dragPieceIndex = -1
        dragOffset = CGSize.zero
        highlightRow = -1
        highlightCol = -1
        highlightValid = false
        prevHighlightRow = -1
        prevHighlightCol = -1
    }

    // MARK: - Game Over Overlay

    var gameOverOverlay: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.white)

                VStack(spacing: 8) {
                    Text("Score")
                        .font(.headline)
                        .foregroundStyle(Color.white.opacity(0.7))
                    Text("\(game.score)")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.yellow)
                }

                if game.score >= game.highScore && game.score > 0 {
                    Text("New High Score!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.yellow)
                }

                Button(action: {
                    game.newGame()
                }) {
                    Text("Play Again")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                }
                .padding(.top, 8)
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.15, green: 0.16, blue: 0.3))
            )
        }
    }

    // MARK: - Combo Popup

    var comboPopup: some View {
        VStack(spacing: 4) {
            if game.lastLinesCleared > 1 {
                Text("\(game.lastLinesCleared)x Lines!")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.yellow)
            }
            if game.comboStreak > 1 {
                Text("Combo x\(game.comboStreak)!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.orange)
            } else if game.lastLinesCleared == 1 {
                Text("Line Clear!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.cyan)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.7))
        )
        .allowsHitTesting(false)
        .transition(.opacity)
    }
}

// MARK: - Color Palette

/// Block colors used throughout the game
private struct BlockColors {
    static func color(for index: Int) -> Color {
        switch index {
        case 0: return Color.red
        case 1: return Color.blue
        case 2: return Color.green
        case 3: return Color.orange
        case 4: return Color.purple
        case 5: return Color.yellow
        case 6: return Color.pink
        default: return Color.gray
        }
    }

    static func darkColor(for index: Int) -> Color {
        switch index {
        case 0: return Color(red: 0.7, green: 0.1, blue: 0.1)
        case 1: return Color(red: 0.1, green: 0.2, blue: 0.7)
        case 2: return Color(red: 0.1, green: 0.5, blue: 0.1)
        case 3: return Color(red: 0.8, green: 0.4, blue: 0.0)
        case 4: return Color(red: 0.5, green: 0.1, blue: 0.5)
        case 5: return Color(red: 0.7, green: 0.6, blue: 0.0)
        case 6: return Color(red: 0.8, green: 0.3, blue: 0.5)
        default: return Color.gray
        }
    }
}

// MARK: - Block Shape Definitions

/// Represents a single cell offset within a block shape
struct CellOffset: Hashable, Sendable {
    let row: Int
    let col: Int
}

/// All available block shapes in the game (no rotation)
final class BlockShape: Identifiable, Hashable, Sendable {
    let id: String
    let cells: [CellOffset]
    let colorIndex: Int

    init(id: String, cells: [CellOffset], colorIndex: Int) {
        self.id = id
        self.cells = cells
        self.colorIndex = colorIndex
    }

    static func == (lhs: BlockShape, rhs: BlockShape) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var width: Int {
        var maxCol = 0
        for c in cells {
            if c.col > maxCol { maxCol = c.col }
        }
        return maxCol + 1
    }

    var height: Int {
        var maxRow = 0
        for c in cells {
            if c.row > maxRow { maxRow = c.row }
        }
        return maxRow + 1
    }
}

/// All the shapes available in the game
struct ShapeLibrary {
    static let allShapes: [BlockShape] = [
        // Single dot
        BlockShape(id: "dot", cells: [CellOffset(row: 0, col: 0)], colorIndex: 0),

        // 1x2 horizontal
        BlockShape(id: "h2", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1)
        ], colorIndex: 1),

        // 1x3 horizontal
        BlockShape(id: "h3", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1), CellOffset(row: 0, col: 2)
        ], colorIndex: 2),

        // 1x4 horizontal
        BlockShape(id: "h4", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1),
            CellOffset(row: 0, col: 2), CellOffset(row: 0, col: 3)
        ], colorIndex: 3),

        // 1x5 horizontal
        BlockShape(id: "h5", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1),
            CellOffset(row: 0, col: 2), CellOffset(row: 0, col: 3),
            CellOffset(row: 0, col: 4)
        ], colorIndex: 4),

        // 2x1 vertical
        BlockShape(id: "v2", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 1, col: 0)
        ], colorIndex: 1),

        // 3x1 vertical
        BlockShape(id: "v3", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 1, col: 0), CellOffset(row: 2, col: 0)
        ], colorIndex: 2),

        // 4x1 vertical
        BlockShape(id: "v4", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 1, col: 0),
            CellOffset(row: 2, col: 0), CellOffset(row: 3, col: 0)
        ], colorIndex: 3),

        // 5x1 vertical
        BlockShape(id: "v5", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 1, col: 0),
            CellOffset(row: 2, col: 0), CellOffset(row: 3, col: 0),
            CellOffset(row: 4, col: 0)
        ], colorIndex: 4),

        // 2x2 square
        BlockShape(id: "sq2", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1)
        ], colorIndex: 5),

        // 3x3 square
        BlockShape(id: "sq3", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1), CellOffset(row: 0, col: 2),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1), CellOffset(row: 1, col: 2),
            CellOffset(row: 2, col: 0), CellOffset(row: 2, col: 1), CellOffset(row: 2, col: 2)
        ], colorIndex: 6),

        // L-shape (bottom-left)
        BlockShape(id: "L_bl", cells: [
            CellOffset(row: 0, col: 0),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1)
        ], colorIndex: 0),

        // L-shape (bottom-right)
        BlockShape(id: "L_br", cells: [
            CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1)
        ], colorIndex: 1),

        // L-shape (top-left)
        BlockShape(id: "L_tl", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 0)
        ], colorIndex: 2),

        // L-shape (top-right)
        BlockShape(id: "L_tr", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 1)
        ], colorIndex: 3),

        // Big L (bottom-left)
        BlockShape(id: "bigL_bl", cells: [
            CellOffset(row: 0, col: 0),
            CellOffset(row: 1, col: 0),
            CellOffset(row: 2, col: 0), CellOffset(row: 2, col: 1), CellOffset(row: 2, col: 2)
        ], colorIndex: 4),

        // Big L (bottom-right)
        BlockShape(id: "bigL_br", cells: [
            CellOffset(row: 0, col: 2),
            CellOffset(row: 1, col: 2),
            CellOffset(row: 2, col: 0), CellOffset(row: 2, col: 1), CellOffset(row: 2, col: 2)
        ], colorIndex: 5),

        // Big L (top-left)
        BlockShape(id: "bigL_tl", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1), CellOffset(row: 0, col: 2),
            CellOffset(row: 1, col: 0),
            CellOffset(row: 2, col: 0)
        ], colorIndex: 6),

        // Big L (top-right)
        BlockShape(id: "bigL_tr", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1), CellOffset(row: 0, col: 2),
            CellOffset(row: 1, col: 2),
            CellOffset(row: 2, col: 2)
        ], colorIndex: 0),

        // T-shape (pointing up)
        BlockShape(id: "T_up", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1), CellOffset(row: 0, col: 2),
            CellOffset(row: 1, col: 1)
        ], colorIndex: 1),

        // T-shape (pointing down)
        BlockShape(id: "T_dn", cells: [
            CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1), CellOffset(row: 1, col: 2)
        ], colorIndex: 2),

        // T-shape (pointing left)
        BlockShape(id: "T_lt", cells: [
            CellOffset(row: 0, col: 0),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1),
            CellOffset(row: 2, col: 0)
        ], colorIndex: 3),

        // T-shape (pointing right)
        BlockShape(id: "T_rt", cells: [
            CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1),
            CellOffset(row: 2, col: 1)
        ], colorIndex: 4),

        // S-shape horizontal
        BlockShape(id: "S_h", cells: [
            CellOffset(row: 0, col: 1), CellOffset(row: 0, col: 2),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1)
        ], colorIndex: 5),

        // Z-shape horizontal
        BlockShape(id: "Z_h", cells: [
            CellOffset(row: 0, col: 0), CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 1), CellOffset(row: 1, col: 2)
        ], colorIndex: 6),

        // S-shape vertical
        BlockShape(id: "S_v", cells: [
            CellOffset(row: 0, col: 0),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1),
            CellOffset(row: 2, col: 1)
        ], colorIndex: 5),

        // Z-shape vertical
        BlockShape(id: "Z_v", cells: [
            CellOffset(row: 0, col: 1),
            CellOffset(row: 1, col: 0), CellOffset(row: 1, col: 1),
            CellOffset(row: 2, col: 0)
        ], colorIndex: 6),
    ]

    static func randomShape() -> BlockShape {
        let index = Int.random(in: 0..<allShapes.count)
        return allShapes[index]
    }

    static func randomSet() -> [BlockShape] {
        return [randomShape(), randomShape(), randomShape()]
    }
}

// MARK: - Game Model

/// A piece the player can place, with a unique identity for tracking
final class GamePiece: Identifiable, Hashable {
    let id: String
    let shape: BlockShape

    init(shape: BlockShape) {
        self.id = UUID().uuidString
        self.shape = shape
    }

    static func == (lhs: GamePiece, rhs: GamePiece) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// The main game model
@Observable final class GameModel {
    static let gridSize = 8

    /// The 8x8 grid. Each cell is -1 if empty, or a colorIndex (0-6) if filled.
    var grid: [[Int]] = Array(repeating: Array(repeating: -1, count: 8), count: 8)

    /// The current set of three pieces available to place
    var currentPieces: [GamePiece?] = [nil, nil, nil]

    /// Current score
    var score: Int = 0

    /// High score
    var highScore: Int = 0

    /// Whether the game is over
    var isGameOver: Bool = false

    /// Number of lines cleared in last move (for combo display)
    var lastLinesCleared: Int = 0

    /// Combo streak counter
    var comboStreak: Int = 0

    /// Set of cells to animate as clearing
    var clearingCells: Set<Int> = []

    init() {
        loadHighScore()
        spawnNewPieces()
    }

    // MARK: - Core Game Logic

    func newGame() {
        grid = Array(repeating: Array(repeating: -1, count: 8), count: 8)
        score = 0
        isGameOver = false
        lastLinesCleared = 0
        comboStreak = 0
        clearingCells = []
        spawnNewPieces()
    }

    func spawnNewPieces() {
        let shapes = ShapeLibrary.randomSet()
        currentPieces = [
            GamePiece(shape: shapes[0]),
            GamePiece(shape: shapes[1]),
            GamePiece(shape: shapes[2])
        ]
    }

    /// Check if a shape can be placed at the given grid position
    func canPlace(shape: BlockShape, atRow row: Int, col: Int) -> Bool {
        for cell in shape.cells {
            let r = row + cell.row
            let c = col + cell.col
            if r < 0 || r >= GameModel.gridSize || c < 0 || c >= GameModel.gridSize {
                return false
            }
            if grid[r][c] != -1 {
                return false
            }
        }
        return true
    }

    /// Place a shape on the grid and handle scoring/clearing
    func placeShape(shape: BlockShape, atRow row: Int, col: Int, pieceIndex: Int) {
        // Place the cells
        for cell in shape.cells {
            let r = row + cell.row
            let c = col + cell.col
            grid[r][c] = shape.colorIndex
        }

        // Add points for placing (1 point per cell)
        score += shape.cells.count

        // Remove the placed piece
        currentPieces[pieceIndex] = nil

        // Check and clear completed lines
        let linesCleared = clearCompletedLines()
        lastLinesCleared = linesCleared

        if linesCleared > 0 {
            comboStreak += 1
            // Scoring: 10 points per line, bonus for combos and multi-line clears
            let linePoints = linesCleared * 10
            let comboBonus = comboStreak > 1 ? comboStreak * 5 : 0
            let multiLineBonus = linesCleared > 1 ? linesCleared * 5 : 0
            score += linePoints + comboBonus + multiLineBonus
        } else {
            comboStreak = 0
        }

        // Check if all three pieces are placed
        let allPlaced = currentPieces[0] == nil && currentPieces[1] == nil && currentPieces[2] == nil
        if allPlaced {
            spawnNewPieces()
        }

        // Check for game over
        if checkGameOver() {
            isGameOver = true
            if score > highScore {
                highScore = score
                saveHighScore()
            }
        }
    }

    /// Clear any completed rows and columns, returns count cleared
    func clearCompletedLines() -> Int {
        var rowsToClear: [Int] = []
        var colsToClear: [Int] = []

        // Check rows
        for r in 0..<GameModel.gridSize {
            var full = true
            for c in 0..<GameModel.gridSize {
                if grid[r][c] == -1 {
                    full = false
                    break
                }
            }
            if full {
                rowsToClear.append(r)
            }
        }

        // Check columns
        for c in 0..<GameModel.gridSize {
            var full = true
            for r in 0..<GameModel.gridSize {
                if grid[r][c] == -1 {
                    full = false
                    break
                }
            }
            if full {
                colsToClear.append(c)
            }
        }

        // Build set of cells to clear for animation
        var cellsToClear = Set<Int>()
        for r in rowsToClear {
            for c in 0..<GameModel.gridSize {
                cellsToClear.insert(r * GameModel.gridSize + c)
            }
        }
        for c in colsToClear {
            for r in 0..<GameModel.gridSize {
                cellsToClear.insert(r * GameModel.gridSize + c)
            }
        }
        clearingCells = cellsToClear

        // Clear the rows
        for r in rowsToClear {
            for c in 0..<GameModel.gridSize {
                grid[r][c] = -1
            }
        }

        // Clear the columns
        for c in colsToClear {
            for r in 0..<GameModel.gridSize {
                grid[r][c] = -1
            }
        }

        return rowsToClear.count + colsToClear.count
    }

    /// Check if any remaining piece can be placed anywhere
    func checkGameOver() -> Bool {
        for piece in currentPieces {
            guard let piece = piece else { continue }
            for r in 0..<GameModel.gridSize {
                for c in 0..<GameModel.gridSize {
                    if canPlace(shape: piece.shape, atRow: r, col: c) {
                        return false
                    }
                }
            }
        }
        return true
    }

    /// Check if a specific piece can be placed anywhere on the board
    func canPieceFit(piece: GamePiece) -> Bool {
        for r in 0..<GameModel.gridSize {
            for c in 0..<GameModel.gridSize {
                if canPlace(shape: piece.shape, atRow: r, col: c) {
                    return true
                }
            }
        }
        return false
    }

    // MARK: - Persistence

    private func saveHighScore() {
        UserDefaults.standard.set(highScore, forKey: "blockblast_highscore")
    }

    private func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: "blockblast_highscore")
    }
}
