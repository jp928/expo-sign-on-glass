import type { StyleProp, ViewStyle } from 'react-native';

export type ChangeEventPayload = {
  signature: string;
};

export type ExpoSignOnGlassModuleEvents = {
  // onDrawingChanged: (params: ChangeEventPayload) => void;
};

export type ExpoSignOnGlassViewType = {
  expose: () => Promise<string>;
  clear: () => Promise<void>;
};

export type ExpoSignOnGlassViewProps = {
  onStartSign?: (event: { nativeEvent: ChangeEventPayload }) => void;
  style?: StyleProp<ViewStyle>;
};
