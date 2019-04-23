<template>
<div>
  <c-list/>
</div>
</template>

<script>
import ComponentList from '@/components/component/List'
import Components from '@/api/Components.js'
export default {
  name: 'list',
  components: {
    "c-list" :ComponentList
  },
  data() {
    return {
    }
  },
  mounted() {
  }
}
</script>

<style scoped>

</style>
