<template>
<div>
  <b-alert show variant="warning">
    <v-icon name="keyboard" scale="2" />
    Work in progress - awesome content on the way ...
  </b-alert>
  <b-alert show variant="secondary">
    A meritocracy, is a place, where people that know about things, make decisions about things, where arguments rule, where facts are valued more than opinions.
  </b-alert>
</div>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/keyboard'
export default {
  name: 'meritocracy',
  components: {
    'v-icon': Icon
  }
}
</script>

<style scoped>
</style>
