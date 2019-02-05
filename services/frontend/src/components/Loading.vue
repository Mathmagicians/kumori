<template>
<b-alert show variant="warning">
  <slot>
    Loading stuff for you …
  </slot>
  <v-icon name="spinner" scale="3" spin />
</b-alert>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/spinner'
export default {
  name: 'loading',
  components: {
    'v-icon': Icon
  },
  props: [],
  computed: {},
  methods: {}
}
</script>

<style scoped>
</style>
