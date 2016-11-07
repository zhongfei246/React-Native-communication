import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  NativeModules, TouchableOpacity,NativeAppEventEmitter
} from 'react-native';

var subscription = NativeAppEventEmitter.addListener(
    'TestEventName',
    (reminder) => console.log('收到OC发来的通知'+reminder.name)
);

class lizhongfei_rn_test extends Component {

  /**
   * js调用原生的函数:点击'点击验证js调用原生函数'之后会调用NativeModules中NativeToast类的showMessage函数
   * @private
   */
  _toast() {
    // showMessage('提示信息内容','显示时长1~5秒','位置['top','center','bottom']')
    NativeModules.NativeToast.showMessage(
        `提示信息\n可以控制显示的时间\nshowTime:[1~5]\n可以控制提示信息显示的位置\nposition:['top','center','bottom']`,
        5,
        'center'
    )
  }

  /**
   * 原生调用js:点击'点击验证原生调用js函数'之后会调用NativeModules中NativeToast类的messageLi函数,在这个函数中发送通知(可带参数)给js,js可接收.其实
   * 利用了上面js调用原生的函数的成果检验发送通知的.
   * @private
   */
  _native_js() {
    NativeModules.NativeToast.messageLi('原生调用js')
  }

  componentWillUnmount() {
    subscription.remove();
  }

  /**
   *
   * @returns {XML}
   */
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome} id="first">
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>

        <TouchableOpacity onPress={ this._toast.bind(this) }>
          <View style={ styles.bottomTitleView }>
            <Text style={ styles.bottomTitle }>点击验证js调用原生函数(alert提示)</Text>
          </View>
        </TouchableOpacity>

        <TouchableOpacity onPress={ this._native_js.bind(this) }>
          <Text style={ styles.native_js }>点击验证原生调用js函数(看Xcode控制台)</Text>
        </TouchableOpacity>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  bottomTitleView:{
    flex:1
  },
  bottomTitle: {
    fontSize:15
  },
  native_js: {
    fontSize:15,
    marginTop:20
  }
});

//  项目名要有所对应
AppRegistry.registerComponent('lizhongfei_rn_test', () => lizhongfei_rn_test);