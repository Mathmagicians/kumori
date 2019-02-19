<template>
<div>
  <p>{{data.name}}
    <weather :state="data.status.value" size="16" />
  </p>
</div>
</template>

<script>
import Weather from '@/components/Weather'
export default {
  name: 'project',
  components: {
    'weather': Weather
  },
  props: {
    data: {
      default: {}
    }
  }
}
</script>

<style scoped>
</style>
