open ReactNative
open Style

let styles = StyleSheet.create({
  "container": Style.viewStyle(~flex=1., ~alignItems=#center, ~justifyContent=#center, ()),
  "box": Style.viewStyle(~width=150.->dp, ~height=150.->dp, ~backgroundColor="#cc0000", ()),
})

@react.component
let make = () => {
  let colorValue = React.useRef(Animated.Value.create(0.))
  let scaleValue = React.useRef(Animated.Value.create(1.))

  let backgroundColorInterpolation = Animated.Value.interpolate(
    colorValue.current,
    Animated.Interpolation.config(
      ~inputRange=[0.0, 1.0],
      ~outputRange=["rgb(255,99,71)", "rgb(99,71,255)"]->Animated.Interpolation.fromStringArray,
      (),
    ),
  )

  let startAnimations = () => {
    Animated.parallel(
      [
        Animated.timing(
          colorValue.current,
          Animated.Value.Timing.config(
            ~toValue=1.0->Animated.Value.Timing.fromRawValue,
            ~duration=1000.0,
            ~useNativeDriver=false,
            (),
          ),
        ),
        Animated.timing(
          scaleValue.current,
          Animated.Value.Timing.config(
            ~toValue=2.0->Animated.Value.Timing.fromRawValue,
            ~duration=500.0,
            ~useNativeDriver=false,
            (),
          ),
        ),
      ],
      {stopTogether: false},
    )->Animated.start()
  }

  let boxStyles = Style.style(
    ~backgroundColor=backgroundColorInterpolation->Animated.StyleProp.color,
    ~transform=[scale(~scale=scaleValue.current->Animated.StyleProp.float)],
    (),
  )

  <View style={styles["container"]}>
    <TouchableOpacity onPress={_ => startAnimations()}>
      <Animated.View style={array([styles["box"], boxStyles])} />
    </TouchableOpacity>
  </View>
}
