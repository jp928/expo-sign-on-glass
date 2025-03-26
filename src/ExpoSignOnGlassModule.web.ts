import { registerWebModule, NativeModule } from 'expo';

import { ExpoSignOnGlassModuleEvents } from './ExpoSignOnGlass.types';

class ExpoSignOnGlassModule extends NativeModule<ExpoSignOnGlassModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoSignOnGlassModule);
