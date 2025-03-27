import { requireNativeView } from "expo";
import * as React from "react";

import {
  ExpoSignOnGlassViewProps,
  ExpoSignOnGlassViewType,
} from "./ExpoSignOnGlass.types";

const NativeView: React.ComponentType<
  ExpoSignOnGlassViewProps & { ref: React.Ref<ExpoSignOnGlassViewType> }
> = requireNativeView("ExpoSignOnGlass");

const ExpoSignOnGlassView = React.forwardRef<
  ExpoSignOnGlassViewType,
  ExpoSignOnGlassViewProps
>((props, ref) => {
  return <NativeView {...props} ref={ref} />;
});

export default ExpoSignOnGlassView;
