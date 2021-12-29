open ReactNative
open Style

let styles = StyleSheet.create({
  "container": Style.viewStyle(~flex=1., ()),
  "content": Style.viewStyle(
    ~height=3000.->dp,
    ~width=2000.->dp,
    ~backgroundColor="rgb(255,99,71)",
    (),
  ),
})

@react.component
let make = () => {
  let (value, setValue) = React.useState(() => Animated.Value.create(1.))

  let backgroundColorInterpolation = Animated.Value.interpolate(
    value,
    Animated.Interpolation.config(
      ~inputRange=[0.0, 3000.0],
      ~outputRange=["rgb(255,99,71)", "rgb(99,71,255)"]->Animated.Interpolation.fromStringArray,
      (),
    ),
  )

  let animatedStyle = Style.viewStyle(
    ~backgroundColor=backgroundColorInterpolation->Animated.StyleProp.color,
    (),
  )
  <ScrollView
    scrollEventThrottle={16}
    onScroll={event => {
      event->ReactNative.Event.ScrollEvent.persist
      setValue(_ => Animated.Value.create(event.nativeEvent.contentOffset.y))
    }}>
    <View style={styles["container"]}>
      <Animated.View style={array([styles["content"], animatedStyle])} />
    </View>
  </ScrollView>
}
