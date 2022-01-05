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
          ~useNativeDriver=true,
          (),
        ),
      )
    }
    1.0->createAnimation->Animated.start(~endCallback=_ => {
      2.0->createAnimation->Animated.start()
    }, ())
  }

  let animatedInterpolate = Animated.Value.interpolate(
    value.current,
    Animated.Interpolation.config(
      ~inputRange=[0.0, 1.0, 2.0],
      ~outputRange=[0.0, 300.0, 0.0]->Animated.Interpolation.fromFloatArray,
      (),
    ),
  )

  let animatedInterpolateInterpolate = Animated.Value.interpolate(
    animatedInterpolate,
    Animated.Interpolation.config(
      ~inputRange=[0., 300.],
      ~outputRange=[1., 0.5]->Animated.Interpolation.fromFloatArray,
      (),
    ),
  )

  let animatedStyles = Style.viewStyle(
    ~opacity=animatedInterpolateInterpolate->Animated.StyleProp.float,
    ~transform=[translateY(~translateY=animatedInterpolate->Animated.StyleProp.float)],
    (),
  )

  <View style={styles["container"]}>
    <TouchableOpacity onPress={_ => startAnimation()}>
      <Animated.View style={array([styles["box"], animatedStyles])}>
        <Animated.Text> {React.string("This is some text.")} </Animated.Text>
      </Animated.View>
    </TouchableOpacity>
  </View>
}
