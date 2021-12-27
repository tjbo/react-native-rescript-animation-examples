// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as ReactNative from "react-native";
import * as Animated$ReactNative from "rescript-react-native/src/apis/Animated.bs.js";

var styles = ReactNative.StyleSheet.create({
      container: {
        alignItems: "center",
        flex: 1,
        justifyContent: "center"
      },
      box: {
        backgroundColor: "#cc0000",
        height: 150,
        width: 150
      }
    });

function Opacity(Props) {
  var value = React.useRef(new (ReactNative.Animated.Value)(1));
  var animatedStyles = {
    opacity: value.current
  };
  return React.createElement(ReactNative.View, {
              style: styles.container,
              children: React.createElement(ReactNative.TouchableOpacity, {
                    onPress: (function (param) {
                        var animation = Animated$ReactNative.timing(value.current, {
                              toValue: 0.0,
                              duration: 1500.0,
                              useNativeDriver: false
                            });
                        return Animated$ReactNative.start(animation, (function (param) {
                                      var animation = Animated$ReactNative.timing(value.current, {
                                            toValue: 1.0,
                                            duration: 1500.0,
                                            useNativeDriver: false
                                          });
                                      return Animated$ReactNative.start(animation, undefined, undefined);
                                    }), undefined);
                      }),
                    children: React.createElement(Animated$ReactNative.View.make, {
                          style: [
                            styles.box,
                            animatedStyles
                          ]
                        })
                  })
            });
}

var make = Opacity;

export {
  styles ,
  make ,
  
}
/* styles Not a pure module */
