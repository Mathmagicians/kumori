/*
Vue.component('nav-dropdown', {
  props : ['items'],
  template: `<ul id="example-1"><li v-for="item in items">{{ item }}</li></ul>`
})
*/

new Vue({
  el: '#app',
  data: {
    appname: 'Kumori'
  },
  methods: {
    writeToTheConsole: function() {
      console.log('Here we go');
    }
  }
})
