open ReactNative
open Style

let styles = StyleSheet.create({
  "container": Style.viewStyle(~flex=1., ~alignItems=#center, ~justifyContent=#center, ()),
  "box": Style.viewStyle(~width=150.->dp, ~height=150.->dp, ~backgroundColor="#cc0000", ()),
})

@react.component
let make = () => {
  let value = React.useRef(Animated.Value.create(1.))

  let startAnimation = () => {
    let createAnimation = (val: float) => {
      Animated.timing(
        value.current,
        Animated.Value.Timing.config(
          ~toValue=val->Animated.Value.Timing.fromRawValue,
          ~duration=1500.0,
          ~useNativeDriver=false,
          (),
        ),
      )
    }
    400.0->createAnimation->Animated.start(~endCallback=_ => {
      value.current->Animated.Value.setValue(1.)
    }, ())
  }

  let animatedStyles = Style.viewStyle(
    ~transform=[translateY(~translateY=value.current->Animated.StyleProp.float)],
    (),
  )

  <View style={styles["container"]}>
    <TouchableOpacity onPress={_ => startAnimation()}>
      <Animated.View style={array([styles["box"], animatedStyles])} />
    </TouchableOpacity>
  </View>
}
