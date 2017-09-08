/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import _ from 'lodash'
import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  TextInput,
  View,
  Button,
  NativeModules,
  SectionList,
  FlatList,
  Dimensions,
  Slider,
  NativeEventEmitter
} from 'react-native';

const { sendData, setThreshold, sync } = NativeModules.MirrorHelper
const emitter = new NativeEventEmitter(NativeModules.ReactNativeEventEmitter)

let threshold = 55
const emptyDictionary = {
  0: {'key':'', 'value':''}
}

class LogView extends Component {
  constructor(props) {
    super(props)
    this.state = {log:[]}
    const subscription = emitter.addListener('log', this.onLog.bind(this))
  }

  render() {
    return (
      <FlatList
        keyExtractor = { () => _.uniqueId() }
        style = {{ flex : 1 }}
        data = {this.state.log}
        renderItem = { (item) => this.renderLog(item) }
        ListHeaderComponent = { () => <Text style = {{
            alignSelf:'center',
            textAlign: 'center',
            textAlignVertical: 'center'
          }}>LOG</Text> }
      />
    )
  }

  renderLog({item}) {
    console.log(item)
    return (
      <Text style = {{
        height: 30,
        fontSize: 12,
        textAlign: 'center',
        color: 'red'
      }}>{ item }</Text>
    )
  }

  onLog(log) {
    console.log(log)
    this.setState({ log: [ ...this.state.log, log ] })
  }
}

class Row extends Component {
  constructor(props) {
    super(props)
    const { item : { item: { key, value }} } = this.props
    this.state = {
      key: key,
      value: value
    }
  }

  render() {
    const { item : { index, item: { key, value }}, updateData, removeRow } = this.props
    return (
      <View style = {{
        flex: 1,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-around',
        height: 50,
        margin: 10,
        backgroundColor: 'yellow'
      }}>
        <TextInput 
          style = {{
            flex: 10,
            textAlign: 'center',
            textAlignVertical: 'center'
          }}
          returnKeyType = 'done'
          placeholder = 'key'
          placeholderTextColor = 'grey'
          value = {this.state.key}
          onChangeText = { text => this.setState({ 'key': text }) }
          onEndEditing = { ({nativeEvent: { text }}) => updateData(index, 'key', text) }
          onSubmitEditing = { ({nativeEvent: { text }}) => updateData(index, 'key', text) }
        />
        <Text style = {{ flex: 1, textAlign: 'center', textAlignVertical: 'center' }}>•</Text>
        <TextInput
          style = {{
            flex: 9,
            textAlign: 'center',
            textAlignVertical: 'center'
          }}
          returnKeyType = 'done'
          placeholder = 'value'
          placeholderTextColor = 'grey'
          value = {this.state.value}
          onChangeText = { text => this.setState({ 'value': text }) }
          onEndEditing = { ({nativeEvent: { text }}) => updateData(index, 'value', text) }
          onSubmitEditing = { ({nativeEvent: { text }}) => updateData(index, 'value', text) }
        />
        <Button
          style = {{ flex: 1 }}
          title = '🗑'
          onPress = {() => removeRow(index)}
        />
      </View>
    )
  }
}

export default class Mirrorator extends Component {
  constructor(props) {
    super(props)

    this.state = emptyDictionary

    this.updateData = this.updateData.bind(this)
    this.removeRow = this.removeRow.bind(this)
  }

  render() {
    return (
      <View style={{flex:1}}>
        <SectionList
          keyExtractor= {() => _.uniqueId()}
          style = {{ marginTop: 30 }}
          contentContainerStyle = {{ }}
          ItemSeparatorComponent = { () => <View style = {{ height: 0 }}/>}
          ListHeaderComponent = { () => <Text style = {{
            alignSelf:'center',
            textAlign: 'center',
            textAlignVertical: 'center'
          }}>DATA</Text> }
          ListFooterComponent = { () => ( 
            <View style = {{ flex: 2, flexDirection: 'row', justifyContent: 'center' }}>
              <Button
                title='SYNC'
                style = {{
                  flex: 1,
                  color: 'blue'
                }}
                onPress = { () => sync() }
              />
              <Button
                title='SEND'
                style = {{
                  flex: 1,
                  color: 'blue'
                }}
                onPress = { () => sendData(this.state) }
              />
            </View>
          )}
          sections = {
            [{
              data: [..._.values(this.state)],
              renderItem: item => <Row item={item} updateData={this.updateData} removeRow={this.removeRow} />
            },{
              data:[{}],
              renderItem: () => 
              <Button 
                onPress = {() => this.setState({ ...this.state, [_.size(this.state)] : { 'key':'', 'value':'' } })}
                title = '➕'
                style = {{
                  alignSelf:'center',
                  textAlign: 'center',
                  textAlignVertical: 'center'
                }}
              />
            },{
              data:[{}],
              renderItem: () => 
              <Slider 
                step = {1}
                minimumValue = {30}
                maximumValue = {127}
                value = {threshold}
                onSlidingComplete = { val => { setThreshold(val); threshold = val } }
                style = {{
                  width: Dimensions.get('window').width - 100,
                  alignSelf:'center'
                }}
              />
            }]
          }
        />
        <LogView/>
      </View>
    );
  }

  updateData(id, type, data) {
    console.log('update data params',id, type, data)
    const other = (type === 'key') 
    ? { 'value': _.get(this.state, `${id}.value`) }
    : { 'key'  : _.get(this.state, `${id}.key`  ) }

    this.setState({ 
      [id]: { [type]: data, ...other}
    })
  }

  removeRow(id) {
    const _state = this.state
    _.unset(_state, `${id}`)
    this.setState(_state)
  }
}

AppRegistry.registerComponent('Mirrorator', () => Mirrorator);
