export default {
  filters: {
    capitalize: function (lower) {
      return lower.charAt(0).toUpperCase() + lower.substr(1)
    },
    toUpperCase: function (upper) {
      return upper.toUpperCase()
    }
  }
}
