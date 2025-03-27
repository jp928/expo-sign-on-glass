import { NativeModule, requireNativeModule } from 'expo';

import { ExpoSignOnGlassModuleEvents } from './ExpoSignOnGlass.types';

declare class ExpoSignOnGlassModule extends NativeModule<ExpoSignOnGlassModuleEvents> {}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoSignOnGlassModule>('ExpoSignOnGlass');
