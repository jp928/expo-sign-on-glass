package expo.modules.signonglass

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import expo.modules.kotlin.Promise
import expo.modules.kotlin.exception.CodedException
import expo.modules.kotlin.functions.Queues

class ExpoSignOnGlassModule : Module() {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  override fun definition() = ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('ExpoSignOnGlass')` in JavaScript.
    Name("ExpoSignOnGlass")

    // Enables the module to be used as a native view. Definition components that are accepted as part of
    // the view definition: Prop, Events.
    View(ExpoSignOnGlassView::class) {
      AsyncFunction("expose") { view: ExpoSignOnGlassView, promise: Promise ->
        try {
          val image = view.getSignatureImage()
          promise.resolve(image)
        } catch (e: Exception) {
         promise.reject(CodedException(message = e.message ?: "Unknown error"))
        }
      }.runOnQueue(Queues.MAIN)

      AsyncFunction("clear") { view: ExpoSignOnGlassView, promise: Promise ->
        view.clearCanvas()
      }.runOnQueue(Queues.MAIN)

      Events("onStartSign")
    }
  }
}
