import { ExpoSignOnGlassView } from "expo-sign-on-glass";
import { useRef } from "react";
import { Button, SafeAreaView, ScrollView, Text, View } from "react-native";

export default function App() {
  const ref = useRef<any>(null);
  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.container}>
        <Text style={styles.header}>Module API Example</Text>
        <Group name="Async functions">
          <Button
            title="Expose signature"
            onPress={async () => {
              // await ExpoSignOnGlass.setValueAsync("Hello from JS!");
              const res = await ref.current.expose();
              console.log(res);
            }}
          />
          <Button
            title="Clear canvas"
            onPress={async () => {
              // await ExpoSignOnGlass.setValueAsync("Hello from JS!");
              await ref.current.clear();
            }}
          />
        </Group>
        <Group name="Views">
          <ExpoSignOnGlassView
            ref={ref}
            style={styles.view}
            onStartSign={(d) => {
              console.log("---------------------->");
              console.log(d);
            }}
          />
        </Group>
      </ScrollView>
    </SafeAreaView>
  );
}

function Group(props: { name: string; children: React.ReactNode }) {
  return (
    <View style={styles.group}>
      <Text style={styles.groupHeader}>{props.name}</Text>
      {props.children}
    </View>
  );
}

const styles = {
  header: {
    fontSize: 30,
    margin: 20,
  },
  groupHeader: {
    fontSize: 20,
    marginBottom: 20,
  },
  group: {
    margin: 20,
    backgroundColor: "#fff",
    borderRadius: 10,
    padding: 20,
  },
  container: {
    flex: 1,
    backgroundColor: "#eee",
  },
  view: {
    flex: 1,
    height: 200,
  },
};
