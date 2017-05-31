import React, {Component} from 'react';
import ReactNative from 'react-native-macos';
import Menu from './menu/';
const {
  StyleSheet,
  Text,
  View,
  Dimensions,
  Navigator
} = ReactNative;
import Container from './content/index'
import menuSource from "./data/"

var defaultLayout = Dimensions.get('window');
export default class App extends Component {
    constructor(props){
        super()
        this.state={
            component: Welcome, //UIExplorerListBase.makeRenderable(BorderExample)
            layout: defaultLayout,
            contentSource:[]
        }
    }
    render(){
        var Component = this.state.component;
        return (
            <View style={styles.container} >
                <View style={[styles.leftPanel, {width: 182}]}>
                   <Menu dataSource={menuSource.data} onPress={(e,key)=>{
                     let source = []
                     if(key&&menuSource.data&&menuSource.data[key]&&menuSource.data[key].data){
                       source = menuSource.data[key].data;
                     }else{
                       source = [];
                     }

                    console.log("000>>>",source)
                     this.setState({contentSource:source})
                   }}></Menu> 
                </View>
                <View style={[styles.rightPanel, {marginLeft:0}]} respondsToLiveResizing >
                  <Container contentSource={this.state.contentSource} />
                </View>
            </View>
        )
    }
}



class Welcome extends React.Component {
  render() {
    return (
      <View style={styles.welcomeWrapper}>
        <Text style={styles.welcomeText}>welcome !</Text>
      </View>
    );
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
  },
  itemWrapper: {
    backgroundColor: '#eaeaea',
  },
  leftPanel: {
    width: 182,
    backgroundColor:"#3B3B3B"
  },
  rightPanel: {
    flex: 1,
    backgroundColor: '#fff',
    // borderWidth:1,
    // borderColor:"red"
  },
  welcomeWrapper: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  welcomeText: {
    color: '#999',
    fontSize: 20,
  }
});