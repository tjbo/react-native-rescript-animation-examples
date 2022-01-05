open ReactNative
open Style

let styles = StyleSheet.create({
  "container": Style.viewStyle(~flex=1., ~alignItems=#center, ~justifyContent=#center, ()),
  "box": Style.viewStyle(~width=150.->dp, ~height=150.->dp, ~backgroundColor="#cc0000", ()),
})

@react.component
let make = () => {
  let value = React.useRef(Animated.ValueXY.create({"x": 0.0, "y": 0.0})).current

  let config = ReactNative.PanResponder.config(
    ~onMoveShouldSetPanResponder=(_e, _g) => true,
    ~onStartShouldSetPanResponder=(_e, _g) => true,
    ~onPanResponderMove={
      (_e, _g) => {
        value->Animated.ValueXY.setValue({"x": _g.dx, "y": _g.dy})
      }
    },
    ~onPanResponderRelease={
      (_e, _g) => {
        let vx = _g.vx
        let vy = _g.vy
        let decayAnimation = Animated.ValueXY.Decay.decay(
          value,
          Animated.ValueXY.Decay.config(
            ~deceleration=0.997,
            ~velocity={"x": vx, "y": vy},
            ~useNativeDriver=false,
            (),
          ),
        )
        decayAnimation->Animated.start(~endCallback=_ => {
          value->Animated.ValueXY.extractOffset
        }, ())
      }
    },
    (),
  )
  let panResponder = PanResponder.create(config)
  let panHandlers = panResponder->PanResponder.panHandlers

  let animatedStyle = Style.viewStyle(~transform=value->Animated.ValueXY.getTranslateTransform, ())

  <View style={styles["container"]}>
    <Animated.View
      onMoveShouldSetResponder={panHandlers->PanResponder.onMoveShouldSetResponder}
      onStartShouldSetResponder={panHandlers->PanResponder.onStartShouldSetResponder}
      onResponderMove={panHandlers->PanResponder.onResponderMove}
      onResponderRelease={panHandlers->PanResponder.onResponderRelease}
      onResponderGrant={panHandlers->PanResponder.onResponderGrant}
      style={array([styles["box"], animatedStyle])}
    />
  </View>
}
