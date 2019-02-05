//todo refactor tech component list, so the view is reusable for both tech components, usecases and services ...
// could we just add tabs in the view, and change what is shown?
// usecases should they have their own component, like technology? (then tech will include usecases as child components)

<template>
<loading v-if="loading.uc" />
<div v-else>
  {{usecases}}
</div>
</template>

<script>
export default {
  name: 'usecases',
  data() {
    return {
      loading: {
        uc: false
      }
    }
  },
  computed: {
    usecases() {
      return this.$store.getters.usecases
    }
  },
  created() {
    this.$store.dispatch('fetchUsecases')
      .then(usecases => {
        this.loading.uc = false
      })
  }
}
</script>
