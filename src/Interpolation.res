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
    0.0->createAnimation->Animated.start(~endCallback=_ => {
      1.0->createAnimation->Animated.start()
    }, ())
  }

  let backgroundColorInterpolation = Animated.Value.interpolate(
    value.current,
    Animated.Interpolation.config(
      ~inputRange=[0.0, 1.0],
      ~outputRange=["rgb(255,99,71)", "rgb(99,71,255)"]->Animated.Interpolation.fromStringArray,
      (),
    ),
  )

  let colorInterpolation = Animated.Value.interpolate(
    value.current,
    Animated.Interpolation.config(
      ~inputRange=[0.0, 1.0],
      ~outputRange=["rgb(99,71,255)", "rgb(255,99,71)"]->Animated.Interpolation.fromStringArray,
      (),
    ),
  )

  let animatedStyles = Style.viewStyle(
    ~backgroundColor=backgroundColorInterpolation->Animated.StyleProp.color,
    (),
  )

  let animatedTextStyle = Style.textStyle(~color=colorInterpolation->Animated.StyleProp.color, ())

  <View style={styles["container"]}>
    <TouchableOpacity onPress={_ => startAnimation()}>
      <Animated.View style={array([styles["box"], animatedStyles])}>
        <Animated.Text style={animatedTextStyle}>
          {React.string("This is some text.")}
        </Animated.Text>
      </Animated.View>
    </TouchableOpacity>
  </View>
}
