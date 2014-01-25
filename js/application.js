/**
 * Created with JetBrains WebStorm.
 * User: hz
 * Date: 2013.12.22.
 * Time: 1:22
 */

//pads left
String.prototype.lpad = function(padString, length) {
  var str = this;
  while (str.length < length)
    str = padString + str;
  return str;
}

//pads right
String.prototype.rpad = function(padString, length) {
  var str = this;
  while (str.length < length)
    str = str + padString;
  return str;
}

Date.prototype.getWeek = function() {
  var onejan = new Date(this.getFullYear(),0,1);
  return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()+1)/7);
}

$(function(){
  App.data();
})