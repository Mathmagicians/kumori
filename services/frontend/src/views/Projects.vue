<template>
<div>
  <b-alert show variant="secondary">
  your projects
  </b-alert>
  <b-alert show variant="warning" v-if="loading">Loading Kumori services …
    <v-icon name="spinner" scale="2" spin />
  </b-alert>
  <b-list-group v-else class="components">
    <b-alert show variant="secondary">
      Kumori is happily governing <b>{{services.length}}</b> services.
    </b-alert>

    <b-list-group-item v-for="service in services" :key="service.name" class="tech-component">
      {{ service }}
    </b-list-group-item>
  </b-list-group>
</div>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/keyboard'
import 'vue-awesome/icons/spinner'
export default {
  name: 'services',
	components: {
		'v-icon': Icon
	},
  data() {
    return {
      loading: false
    }
  },
  computed: {
    services() {
      return this.$store.state.services
    }
  },
  created() {
    this.loading = true
    this.$store.dispatch('fetchServices')
      .then(services => {
        this.loading = false
      })
  }
}
</script>

<style scoped>
</style>
