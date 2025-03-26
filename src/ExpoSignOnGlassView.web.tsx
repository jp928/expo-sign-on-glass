import * as React from 'react';

import { ExpoSignOnGlassViewProps } from './ExpoSignOnGlass.types';

export default function ExpoSignOnGlassView(props: ExpoSignOnGlassViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
