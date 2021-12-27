/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

// Converted from
// https://github.com/facebook/react-native/blob/0.64-stable/template/App.js
// With a few tweaks

open ReactNative

include ReactNativeHelloWorldUtils

//  Here is StyleSheet that is using Style module to define styles for your components
//  The main different with JavaScript components you may encounter in React Native
//  is the fact that they **must** be defined before being referenced
//  (so before actual component definitions)
//  More at https://rescript-react-native.github.io/docs/style

let styles = {
  open Style
  StyleSheet.create({
    "sectionContainer": viewStyle(~marginTop=32.->dp, ~paddingHorizontal=24.->dp, ()),
    "sectionTitle": textStyle(~fontSize=24., ~fontWeight=#_600, ()),
    "sectionDescription": textStyle(~marginTop=8.->dp, ~fontSize=18., ~fontWeight=#_400, ()),
    "highlight": textStyle(~fontWeight=#_700, ()),
  })
}

let useIsDarkMode = () => {
  Appearance.useColorScheme()
  ->Js.Null.toOption
  ->Belt.Option.map(scheme => scheme === #dark)
  ->Belt.Option.getWithDefault(false)
}

// You can notice here the difference when you write a component that is not exported
// We wrap this into a module and use a "make" function
// So we can use <Section /> in JSX like if it was a "const Section = ..." in JavaScript.
module Section = {
  @react.component
  let make = (~title: string, ~children) => {
    let isDarkMode = useIsDarkMode()
    <View style={styles["sectionContainer"]}>
      <Text
        style={
          open Style
          array([
            styles["sectionTitle"],
            textStyle(~color=isDarkMode ? colors.white : colors.black, ()),
          ])
        }>
        {title->React.string}
      </Text>
      <Text
        style={
          open Style
          array([
            styles["sectionDescription"],
            textStyle(~color=isDarkMode ? colors.white : colors.black, ()),
          ])
        }>
        {children}
      </Text>
    </View>
  }
}

@react.component
let app = () => {
  let isDarkMode = useIsDarkMode()
  <SafeAreaView>
    <StatusBar barStyle={isDarkMode ? #lightContent : #darkContent} /> <Opacity />
  </SafeAreaView>
}
