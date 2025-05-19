import ExpoModulesCore

public class ExpoSignOnGlassModule: Module {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  public func definition() -> ModuleDefinition {
    Name("ExpoSignOnGlass")

    View(ExpoSignOnGlassView.self) {
        AsyncFunction("expose") {  (view: ExpoSignOnGlassView, promise: Promise)  in
          if let image = view.getSignatureImage() {
          // Compress the image data with medium quality (0.5)
            if let compressedData = image.jpegData(compressionQuality: 0.5) {
              let base64String = compressedData.base64EncodedString()
              let dataUri = "data:image/jpeg;base64," + base64String
              promise.resolve(dataUri)
            } else {
              promise.reject(Exception(name: "CompressionError", description: "Failed to compress image"))
            }
          } else {
            promise.reject(Exception(name: "GetSignatureError", description: "Failed to get signature image"))
          }
        }.runOnQueue(.main)

        AsyncFunction("clear") { (view: ExpoSignOnGlassView, promise: Promise)  in
          view.clearCanvas()
        }.runOnQueue(.main)

        Events("onStartSign") 

        Prop("thickness") { (view: ExpoSignOnGlassView, thickness: CGFloat) in
          view.setThickness(thickness)
        }
    }

  }
}
