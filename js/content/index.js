import React, {Component} from 'react';
import ReactNative from 'react-native-macos';
const {View,Text,StyleSheet,TouchableOpacity,ScrollView,ListView} = ReactNative;

export default class Container extends Component {
    static defaultProps = {
        contentSource:[],
    }
    // 初始化模拟数据
    constructor(props) {
        super(props);
        this.state = {
            dataSource:[]
        };
    }
    render() {
        const ds = new ListView.DataSource({rowHasChanged: (r1, r2) =>{
            return  r1 !== r2;
        }});
        let dataSource = ds.cloneWithRows(this.props.contentSource);

        return (
            <View style={styles.container}>
                <ListView
                  dataSource={dataSource}
                  enableEmptySections={true}
                  renderRow={this.renderRow.bind(this)}
                />
            </View>
        );
    }
    renderRow(rowData){
        return(
            <View style={styles.list}>
                <View style={{flex:1}}>
                    <TouchableOpacity style={{paddingBottom:5}} onPress={()=>{
                        console.log("-23-->")    
                    }}>
                        <Text style={{color:"#0074FD"}}>{rowData.title}</Text>
                    </TouchableOpacity>
                    <View style={{minHeight:12}}>
                        <Text style={{lineHeight:12,fontSize:12,color:"#616161"}}>
                            <Text>{rowData.des}</Text>
                        </Text>
                    </View>
                </View>
            </View>
        )
    }
}


var styles = StyleSheet.create({
    container:{
        flex:1,
        paddingTop:38
    },
    list:{
        flex:1,
        marginBottom:1,
        paddingHorizontal:12,
        paddingTop:10,
        paddingBottom:10,
        // height:100,
        // paddingVertical:10,
        justifyContent: 'center',
        backgroundColor: '#fff',
        borderBottomWidth: 1,
        borderBottomColor: '#E2DEDE'
    }
})
