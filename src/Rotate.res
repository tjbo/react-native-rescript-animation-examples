open ReactNative
open Style

let styles = StyleSheet.create({
  "container": Style.viewStyle(~flex=1., ~alignItems=#center, ~justifyContent=#center, ()),
  "box": Style.viewStyle(~width=150.->dp, ~height=150.->dp, ~backgroundColor="#cc0000", ()),
})

@react.component
let make = () => {
  let value = React.useRef(Animated.Value.create(0.))
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
    1.0->createAnimation->Animated.start()
  }

  let rotateInterpolation = Animated.Value.interpolate(
    value.current,
    Animated.Interpolation.config(
      ~inputRange=[0.0, 1.0],
      // we can also use radians here
      ~outputRange=["0deg", "360deg"]->Animated.Interpolation.fromStringArray,
      (),
    ),
  )

  let animatedStyles = Style.viewStyle(
    // we could also just rotateX or rotateY
    ~transform=[rotate(~rotate=rotateInterpolation->Animated.StyleProp.angle)],
    (),
  )
  <View style={styles["container"]}>
    <TouchableOpacity onPress={_ => startAnimation()}>
      <Animated.View style={array([styles["box"], animatedStyles])} />
    </TouchableOpacity>
  </View>
}
