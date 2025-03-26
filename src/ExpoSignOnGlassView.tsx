import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoSignOnGlassViewProps } from './ExpoSignOnGlass.types';

const NativeView: React.ComponentType<ExpoSignOnGlassViewProps> =
  requireNativeView('ExpoSignOnGlass');

export default function ExpoSignOnGlassView(props: ExpoSignOnGlassViewProps) {
  return <NativeView {...props} />;
}
