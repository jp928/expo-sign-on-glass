import ExpoModulesCore
import PencilKit
import UIKit

// This view will be used as a native component. Make sure to inherit from `ExpoView`
// to apply the proper styling (e.g. border radius and shadows).
class ExpoSignOnGlassView: ExpoView {
    private var signatureDelegate: SignOnGlassViewDelegate?
    let canvasView = PKCanvasView()
    let onStartSign = EventDispatcher()
    var isPencilInputEnabled: Bool = true
    var tool: PKTool
    var drawingData: Data?
    
    required init(appContext: AppContext? = nil) {
        tool = PKInkingTool(.pen, color: .black, width: 1.0)
        super.init(appContext: appContext)
        clipsToBounds = true
        // Configure the canvas
        canvasView.tool = tool
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        // Create and store delegate
        signatureDelegate = SignOnGlassViewDelegate { [weak self] base64String in
            self?.onStartSign(["signature": base64String])
        }
        
        // Assign delegate
        canvasView.delegate = signatureDelegate
        
        addSubview(canvasView)
        
        // Set up constraints for the canvas view
        canvasView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        canvasView.frame = bounds
    }
    
    func configurePencilInput() {
        canvasView.isUserInteractionEnabled = isPencilInputEnabled
    }
    
    func setPencilColor(fromHexString hexString: String) {
        let color = UIColor(hex: hexString) ?? .black
        if let inkTool = tool as? PKInkingTool {
            tool = PKInkingTool(inkTool.inkType, color: color, width: inkTool.width)
            canvasView.tool = tool
        }
    }

    func setThickness(_ thickness: CGFloat) {
        if let inkTool = tool as? PKInkingTool {
            tool = PKInkingTool(inkTool.inkType, color: inkTool.color, width: thickness)
            canvasView.tool = tool
        }
    }
    
    func clearCanvas() {
        signatureDelegate?.isClearing = true
        canvasView.drawing = PKDrawing()
    }
    
    func getSignatureImage() -> UIImage? {
        return canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
    }
    
    func getSignatureData() -> Data? {
        return canvasView.drawing.dataRepresentation()
    }
}

class SignOnGlassViewDelegate: NSObject, PKCanvasViewDelegate {
    let onStartSign: (String) -> Void
    var isClearing: Bool = false
    init(onStartSign: @escaping (String) -> Void) {
        self.onStartSign = onStartSign
        super.init()
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        if isClearing {
            isClearing = false
            return
        }

        let drawingData = canvasView.drawing.dataRepresentation()
        if drawingData.isEmpty {
            return
        }
        let base64String = drawingData.base64EncodedString()
        onStartSign(base64String)
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
