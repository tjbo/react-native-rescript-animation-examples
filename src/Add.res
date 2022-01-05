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
    300.0->createAnimation->Animated.start(~endCallback=_ => {
      0.0->createAnimation->Animated.start()
    }, ())
  }

  let newAnimationValue = Animated.Value.add(value.current, Animated.Value.create(150.0))

  let animatedStyles = Style.viewStyle(
    ~transform=[translateY(~translateY=newAnimationValue->Animated.StyleProp.float)],
    (),
  )
  <View style={styles["container"]}>
    <TouchableOpacity onPress={_ => startAnimation()}>
      <Animated.View style={array([styles["box"], animatedStyles])} />
    </TouchableOpacity>
  </View>
}
