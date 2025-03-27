package expo.modules.signonglass

import android.view.MotionEvent
import android.graphics.Bitmap
import android.content.Context
import com.github.gcacace.signaturepad.views.SignaturePad
import expo.modules.kotlin.AppContext
import expo.modules.kotlin.viewevent.EventDispatcher
import expo.modules.kotlin.views.ExpoView
import android.util.Base64
import java.io.ByteArrayOutputStream

class ExpoSignOnGlassView(context: Context, appContext: AppContext) : ExpoView(context, appContext) {
  // Creates and initializes an event dispatcher for the `onLoad` event.
  // The name of the event is inferred from the value and needs to match the event name defined in the module.
  private val onStartSign by EventDispatcher()

  // Defines a SignatureView that will be used as the root subview.
  internal val signatureView = SignaturePad(context, null)
  init {
    
    signatureView.setOnSignedListener(object : SignaturePad.OnSignedListener {
        override fun onStartSigning() {
          val eventData = mapOf(
            "signature" to "onStartSigning"
          )
               
          onStartSign(eventData)
        }

        override fun onSigned() {
            // Optional: Handle when signature is completed
        }

        override fun onClear() {
            // Optional: Handle when signature is cleared
        }
    })
   
    addView(signatureView)
  }

  fun clearCanvas() {
   signatureView.clear()
  }

  fun getSignatureImage(): String {
    val bitmap = signatureView.getSignatureBitmap()
    val outputStream = ByteArrayOutputStream()
    
    // Compress the bitmap to JPEG with 50% quality
    bitmap.compress(Bitmap.CompressFormat.JPEG, 50, outputStream)
    
    // Convert to base64 and add data URI header
    val base64String = Base64.encodeToString(outputStream.toByteArray(), Base64.DEFAULT)
    return "data:image/jpeg;base64,$base64String"
  }
}
